import Foundation
import Combine

enum FriendListType: Int {
    case empty
    case friendsOnly
    case friendsWithInvite
}

class FriendViewModel {
    @Published var user: User?
    @Published var friends: [Friend] = []
    @Published var invites: [Friend] = []
    @Published private(set) var filteredFriends: [Friend] = []
    private let type: FriendListType
    private var cancellables = Set<AnyCancellable>()
    
    init(type: FriendListType) {
        self.type = type
    }
    
    func fetchData() {
        ApiService.shared.fetchUserData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
                switch complete {
                case .failure(let error):
                    //TODO: error handle
                    break
                default: break
                    //
                }
                
            }, receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.user = (self.type == .empty) ? User(name: users.first?.name ?? "", kokoid: "") : users.first
            })
            .store(in: &cancellables)
        
        var publisher: AnyPublisher<[Friend], Error>
        switch type {
        case .empty:
            publisher = ApiService.shared.fetchEmptyFriendList()
        case .friendsOnly:
            mergeTwoSources()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in
                    //TODO: error handle
                }, receiveValue: { [weak self] friends in
                    guard let self = self else { return }
                    self.friends = friends.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                })
                .store(in: &cancellables)
            return
        case .friendsWithInvite:
            publisher = ApiService.shared.fetchFriendListWithInvites()
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                //TODO: error handle
            }, receiveValue: { [weak self] friends in
                guard let self = self else { return }
                self.invites = friends
                    .filter { $0.status == StatusType.inviting.rawValue }
                    .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                self.friends = friends
                    .filter { $0.status != StatusType.inviting.rawValue }
                    .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
            })
            .store(in: &cancellables)
    }
    
    private func mergeTwoSources() -> AnyPublisher<[Friend], Error> {
        Publishers.Zip(
            ApiService.shared.fetchFriendList1(),
            ApiService.shared.fetchFriendList2()
        )
        .map { list1, list2 in
            self.merge(list1, list2)
        }
        .eraseToAnyPublisher()
    }
    
    func merge(_ list1: [Friend], _ list2: [Friend]) -> [Friend] {
        var merged: [String: Friend] = [:]
        let all = list1 + list2
        
        for friend in all {
            guard friend.status != StatusType.inviting.rawValue else { continue }
            if let existing = merged[friend.fid] {
                let date1 = existing.updateDate.toDate() ?? Date.distantPast
                let date2 = friend.updateDate.toDate() ?? Date.distantPast
                if date2 > date1 {
                    merged[friend.fid] = friend
                }
            } else {
                merged[friend.fid] = friend
            }
        }
        return Array(merged.values)
    }
    
    func filterFriends(by keyword: String) {
        if keyword.isEmpty {
            filteredFriends = friends
        } else {
            filteredFriends = friends.filter { $0.name.contains(keyword) }
        }
    }
}
