//
//  PlaybackRepository.swift
//  SimpleYouTubeApp
//

import Foundation

protocol PlaybackRepository {
    func getPlaybackItem() async throws -> PlaybackItem
}
