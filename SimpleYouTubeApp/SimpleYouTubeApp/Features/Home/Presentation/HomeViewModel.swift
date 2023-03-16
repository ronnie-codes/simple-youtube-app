//
//  HomeViewModel.swift
//  SimpleYouTubeApp
//

import Foundation

protocol HomeViewModel {
    var items: [HomeItemViewModel] { get }
}

struct HomeViewModelDefault: HomeViewModel {
    let items: [HomeItemViewModel]

    init(home: Home) {
        let videoContents = home.contents.contents.filter {
            $0.type == .item && $0.content?.type == .video
        }
        let items = videoContents.compactMap {
            HomeItemViewModelDefault(item: $0.content)
        }
        self.items = items
    }
}
