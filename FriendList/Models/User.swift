import Foundation

struct UserResponse: Codable {
    let response: User
}

struct User: Codable {
    let name: String
    let kokoid: String
}
