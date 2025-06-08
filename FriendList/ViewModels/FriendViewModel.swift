import Foundation
import Combine

enum FriendListType: Int {
    case empty
    case friendsOnly
    case friendsWithInvite
}

class FriendViewModel {
    @Published var user: User?  //個人資料
    @Published var friends: [Friend] = [] //已經是朋友的那些人
    @Published var invites: [Friend] = [] //送出邀請的那些人
    @Published private(set) var filteredFriends: [Friend] = []
    private let type: FriendListType
    private var cancellables = Set<AnyCancellable>()
    
    init(type: FriendListType) {
        self.type = type
    }
    
    func fetchData() {
        if type != .empty {
            ApiService.shared.fetchUserData()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { complete in
                    switch complete {
                    case .failure(let error):
                        print("--- \(error)")
                    default: break
                        //
                    }
                    
                }, receiveValue: { [weak self] users in
                    self?.user = users.first
                })
                .store(in: &cancellables)
        }
        
        var publisher: AnyPublisher<[Friend], Error>
        
        switch type {
        case .empty:
            publisher = ApiService.shared.fetchEmptyFriendList()
        case .friendsOnly:
            mergeTwoSources()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in
                }, receiveValue: { [weak self] friends in
                    self?.friends = friends
                })
                .store(in: &cancellables)
            return
        case .friendsWithInvite:
            publisher = ApiService.shared.fetchFriendListWithInvites()
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] friends in
                self?.invites = friends.filter { $0.status == StatusType.inviting.rawValue }
                self?.friends = friends.filter { $0.status != StatusType.inviting.rawValue }
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
