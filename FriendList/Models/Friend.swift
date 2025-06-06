import Foundation

enum StatusType:Int {
    case invited, finish, inviting
}

struct FriendListResponse: Codable {
    let response: [Friend]
}

struct Friend: Codable, Hashable {
    let status: Int // 0:invited, 1:finished, 2:inviting
    let name: String
    let isTop: String // "0", "1"
    let fid: String // "001"
    let updateDate: String //"2019/08/02" or "20190804"
}
