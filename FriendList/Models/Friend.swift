import Foundation

struct FriendListResponse: Codable {
    let response: [Friend]
}

struct Friend: Codable {
    let status: Int // 0:邀請送出, 1:已完成, 2:邀請中
    let name: String
    let isTop: String // 可能為"0"或"1"，根據實際情況選擇合適的類型
    let fid: String // "001"
    let updateDate: String // 可能為"2019/08/02"或"20190804"，根據實際情況選擇合適的日期格式
}
