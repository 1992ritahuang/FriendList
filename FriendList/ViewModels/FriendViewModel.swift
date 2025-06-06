import Foundation
import Combine

class FriendViewModel {
    @Published var user: User?  //個人資料
    @Published var friends: [Friend] = [] //已經是朋友的那些人
    @Published var invites: [Friend] = [] //送出邀請的那些人
    
    private var cancellables = Set<AnyCancellable>()

    func fetchData() {
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
        
        ApiService.shared.fetchFriendListWithInvites()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] friends in
                self?.invites = friends.filter { $0.status == 0 }
                self?.friends = friends
            })
            .store(in: &cancellables)
    }
}
