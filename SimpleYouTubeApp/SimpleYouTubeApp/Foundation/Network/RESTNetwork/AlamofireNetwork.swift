//
//  AlamofireNetwork.swift
//  SimpleYouTubeApp
//

import Alamofire
import Foundation

final class AlamofireNetwork: RESTNetwork {
    private let serverURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(serverURL: URL, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.serverURL = serverURL
        self.encoder = encoder
        self.decoder = decoder
    }

    func request<Parameters: Encodable, Response: Decodable>(method: HTTPMethod, path: String, params: Parameters) async throws -> Response {
        let url = serverURL.appendingPathComponent(path)
        let request = AF.request(url, method: method.toAlamofireHTTPMethod(), parameters: params, encoder: JSONParameterEncoder(encoder: encoder))
        let response = try await request.serializingDecodable(Response.self, decoder: decoder).value
        return response
    }

    func request<Response: Decodable>(method: HTTPMethod, path: String) async throws -> Response {
        let url = serverURL.appendingPathComponent(path)
        let request = AF.request(url, method: method.toAlamofireHTTPMethod())
        let response = try await request.serializingDecodable(Response.self, decoder: decoder).value
        return response
    }
}

private extension HTTPMethod {
    func toAlamofireHTTPMethod() -> Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .patch:
            return .patch
        case .put:
            return .put
        }
    }
}
