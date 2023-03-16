//
//  HomeRepositoryDefault.swift
//  SimpleYouTubeApp
//

import Foundation

final class HomeRepositoryDefault: HomeRepository {
    private let path: String
    private let network: RESTNetwork

    init(network: RESTNetwork, path: String) {
        self.network = network
        self.path = path
    }

    func getHome() async throws -> Home {
        try await network.request(method: .get, path: path)
    }
}

final class HomeRepositoryMock: HomeRepository {
    func getHome() async throws -> Home {
        let jsonData = try Data(contentsOf: R.file.homeResponseJson.url()!)
        let home = try JSONDecoder.snakeCase.decode(Home.self, from: jsonData)
        return home
    }
}
