import UIKit
import Combine

fileprivate enum Section: Int, CaseIterable {
    case invite
    case segment
    case search
    case friends
    case empty
}

fileprivate enum Item: Hashable, Sendable {
    case invite(Friend)
    case segment(String)
    case search(String)
    case friend(Friend)
    case empty
}

class FriendViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblKokoID: UILabel!
    
    var viewModel: FriendViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .pinkEC008C
        setupNavigationBar()
        setupNavigationBarItems()
        configureCollectionView()
        configureDataSource()
        guard let viewModel = viewModel else { return }
        bindViewModel(viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData()
    }

    private func bindViewModel(_ viewModel: FriendViewModel) {
        Publishers.CombineLatest3(viewModel.$user, viewModel.$friends, viewModel.$invites)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user, friends, invites in
                guard let self = self else { return }
                self.applySnapshot(friends: friends, invites: invites)
                self.lblName.text = user?.name ?? ""
                self.lblKokoID.text = "KOKO ID: \(user?.kokoid ?? "")"
            }
            .store(in: &cancellables)
        
    }
    
    //MARK: Navigation bar related

    private func setupNavigationBarItems() {
        let withdrawButton = UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw"), style: .plain, target: self, action: #selector(withdrawTapped))
        let transferButton = UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer"), style: .plain, target: self, action: #selector(transferTapped))
        navigationItem.leftBarButtonItems = [withdrawButton, transferButton]

        let scanButton = UIBarButtonItem(image: UIImage(named: "icNavPinkScan"), style: .plain, target: self, action: #selector(scanTapped))
        navigationItem.rightBarButtonItem = scanButton
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .grayFCFCFC
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc private func withdrawTapped() {}
    @objc private func transferTapped() {}
    @objc private func scanTapped() {}
    
    //MARK: collectionView related

    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.collectionViewLayout.register(SeparatorDecorationView.self, forDecorationViewOfKind: SeparatorDecorationView.elementKind)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .invite(let friend):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InviteCell", for: indexPath) as! InviteCell
                cell.configure(with: friend)
                return cell
            case .segment(let title):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: indexPath) as! SegmentCell
                cell.configure(title: title)
                return cell
            case .search:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
                cell.configure()
                return cell
            case .friend(let friend):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
                cell.configure(with: friend)
                return cell
            case .empty:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                cell.configure(with: self)
                return cell
            }
        }

    }

    private func applySnapshot(friends: [Friend], invites: [Friend]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.invite, .segment, .search, .friends])
        snapshot.appendItems(invites.map { .invite($0) }, toSection: .invite)
        snapshot.appendItems(["好友", "聊天"].map { .segment($0) }, toSection: .segment)
        
        if friends.isEmpty {
            snapshot.appendSections([.empty])
            snapshot.appendItems([.empty], toSection: .empty)
        } else {
            snapshot.appendItems([.search("search")], toSection: .search)
            snapshot.appendItems(friends.map { .friend($0) }, toSection: .friends)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = Section(rawValue: sectionIndex)!
            var layoutSection: NSCollectionLayoutSection

            switch section {
            case .invite:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .continuous

//                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
//                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//                layoutSection.boundarySupplementaryItems = [header]

            case .segment:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(48))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                layoutSection = NSCollectionLayoutSection(group: group)

            case .search:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                layoutSection = NSCollectionLayoutSection(group: group)

            case .friends:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
                layoutSection = NSCollectionLayoutSection(group: group)
//                layoutSection.orthogonalScrollingBehavior = .continuous
                
            case .empty:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(445))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
                return NSCollectionLayoutSection(group: group)
            }

            return layoutSection
        }
    }
}

extension FriendViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        //TODO: to set KOKO ID
        return false
    }
}
