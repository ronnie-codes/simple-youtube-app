//
//  PlaybackRespositoryDefault.swift
//  SimpleYouTubeApp
//

import Foundation

final class PlaybackRepositoryDefault: PlaybackRepository {
    private let path: String
    private let network: RESTNetwork

    init(network: RESTNetwork, path: String) {
        self.network = network
        self.path = path
    }

    func getPlaybackItem() async throws -> PlaybackItem {
        try await network.request(method: .get, path: path)
    }
}

final class PlaybackRepositoryMock: PlaybackRepository {
    func getPlaybackItem() async throws -> PlaybackItem {
        let jsonData = try Data(contentsOf: R.file.playbackResponseJson.url()!)
        let playbackItem = try JSONDecoder.snakeCase.decode(PlaybackItem.self, from: jsonData)
        return playbackItem
    }
}
