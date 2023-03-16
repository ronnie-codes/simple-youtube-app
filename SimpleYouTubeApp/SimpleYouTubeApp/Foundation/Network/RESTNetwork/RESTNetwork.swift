//
//  Network.swift
//  SimpleYouTubeApp
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
}

protocol RESTNetwork {
    func request<Parameters: Encodable, Response: Decodable>(method: HTTPMethod, path: String, params: Parameters) async throws -> Response
    func request<Response: Decodable>(method: HTTPMethod, path: String) async throws -> Response
}
