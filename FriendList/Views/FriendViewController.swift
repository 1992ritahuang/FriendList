import UIKit
import Combine

class FriendViewController: UIViewController {
    private let viewModel = FriendViewModel()
    private var cancellables = Set<AnyCancellable>() // 用於管理 Combine 的訂閱

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemPink // 設置 navigation bar tintColor 為 hotPink
        setupNavigationBarItems()
        bindViewModel() // 綁定 ViewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFriends() // 使用 ViewModel 方法
    }

    private func bindViewModel() {
        viewModel.$friends
            .receive(on: DispatchQueue.main) // 確保更新 UI 在主線程
            .sink { [weak self] friends in
                print("Updated friends: \(friends)")
            }
            .store(in: &cancellables)
    }

    private func setupNavigationBarItems() {
        let withdrawButton = UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw"), style: .plain, target: self, action: #selector(withdrawTapped))
        let transferButton = UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer"), style: .plain, target: self, action: #selector(transferTapped))
        navigationItem.leftBarButtonItems = [withdrawButton, transferButton]

        let scanButton = UIBarButtonItem(image: UIImage(named: "icNavPinkScan"), style: .plain, target: self, action: #selector(scanTapped))
        navigationItem.rightBarButtonItem = scanButton
    }

    @objc private func withdrawTapped() {
        // 處理 withdraw 按鈕點擊事件
    }

    @objc private func transferTapped() {
        // 處理 transfer 按鈕點擊事件
    }

    @objc private func scanTapped() {
        // 處理 scan 按鈕點擊事件
    }
}
