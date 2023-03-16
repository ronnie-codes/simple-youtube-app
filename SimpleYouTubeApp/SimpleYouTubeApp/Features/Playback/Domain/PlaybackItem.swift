//
//  Playback.swift
//  SimpleYouTubeApp
//

import Foundation

struct PlaybackItem: Decodable {
    let basicInfo: BasicInfo
    let primaryInfo: PrimaryInfo
    let secondaryInfo: SecondaryInfo
    let streamingData: StreamingData

    struct BasicInfo: Decodable {
        let id: String
    }

    struct PrimaryInfo: Decodable {
        let title: Label
        let shortDescription: String?
        let thumbnail: [Thumbnail]?
        let viewCount: Label
        let published: Label
    }

    struct SecondaryInfo: Decodable {
        let title: Label
        let shortDescription: String?
        let thumbnail: [Thumbnail]?
        let viewCount: Label
        let published: Label
    }

    struct StreamingData: Decodable {
        let hlsManifestUrl: URL
    }
}
