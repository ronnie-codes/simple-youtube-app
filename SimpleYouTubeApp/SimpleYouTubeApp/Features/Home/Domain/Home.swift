//
//  Home.swift
//  SimpleYouTubeApp
//

import Foundation

struct Home: Decodable {
    let contents: Contents

    struct Contents: Decodable {
        let contents: [Content]
    }

    struct Content: Decodable {
        let type: `Type`
        let content: Item?

        enum `Type`: String, Decodable {
            case grid = "RichGrid"
            case video = "Video"
            case shelf = "RichShelf"
            case item = "RichItem"
            case mix = "Mix"
            case section = "RichSection"
            case continuation = "ContinuationItem"
        }

        struct Item: Decodable {
            let id: String?
            let type: `Type`
            let title: Label
            let shortViewCount: Label?
            let duration: Label?
            let published: Label?
            let thumbnails: [Thumbnail]?
            let author: Author?
        }
    }
}
