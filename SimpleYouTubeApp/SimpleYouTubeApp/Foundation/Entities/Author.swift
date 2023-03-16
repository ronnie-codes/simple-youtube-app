//
//  Author.swift
//  SimpleYouTubeApp
//

struct Author: Decodable {
    let id: String
    let name: String
    let thumbnails: [Thumbnail]
}
