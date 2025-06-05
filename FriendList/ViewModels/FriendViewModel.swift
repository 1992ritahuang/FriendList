import Foundation
import Combine

class FriendViewModel {
    @Published var friends: [Friend] = [] // 使用 Combine 的 @Published 屬性
    private var cancellables = Set<AnyCancellable>() // 用於管理 Combine 的訂閱

    func fetchFriends() {
        ApiService.shared.fetchFriendList1()
            .receive(on: DispatchQueue.main) // 確保更新 UI 在主線程
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching friends: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] friendNames in
                self?.friends = friendNames
            })
            .store(in: &cancellables)
    }
}
