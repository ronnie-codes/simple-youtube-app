//
//  FilterService.swift
//  SimpleYouTubeApp
//

import Foundation

protocol FilterService {
    func filter(images: [URL]) -> [URL]
}

final class FilterServiceDefault: FilterService {
    private let visionService: any VisionService
    private let filters: [String]

    init(visionService: any VisionService, filters: [String]) {
        self.visionService = visionService
        self.filters = filters
    }

    func filter(images _: [URL]) -> [URL] {
        []
    }
}

final class FilterServiceMock: FilterService {
    func filter(images _: [URL]) -> [URL] {
        []
    }
}

//        let filters: [String] = try! JSONDecoder.default.decode([String].self, from: Data(contentsOf: R.file.filtersJson.url()!))
