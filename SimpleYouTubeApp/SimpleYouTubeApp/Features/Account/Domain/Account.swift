//
//  Account.swift
//  SimpleYouTubeApp
//

import Foundation

struct Account: Decodable {
    let status: Status
    let data: Verification?
    let credentials: Credentials?

    enum Status: String, Decodable {
        case pending
        case success
    }

    struct Verification: Decodable {
        let verificationUrl: URL
        let userCode: String
    }

    struct Credentials: Codable {
        let accessToken: String
        let refreshToken: String
        let expires: Date
    }
}
