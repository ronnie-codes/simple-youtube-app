//
//  PlaybackRouter.swift
//  SimpleYouTubeApp
//

import Foundation
import SwiftUI

protocol PlaybackRouter {
    static func createModule(playbackId: String) -> Module
}

final class PlaybackRouterDefault: PlaybackRouter {
    static func createModule(playbackId: String) -> Module {
        let network = AlamofireNetwork(serverURL: URL(string: Bundle.main.value(for: .serverURL)!)!, decoder: JSONDecoder.snakeCase)
        let repository = PlaybackRepositoryDefault(network: network, path: "video-info/\(playbackId)")
        let interactor = PlaybackInteractorDefault(repository: repository)
        let router = PlaybackRouterDefault()
        let presenter = PlaybackPresenterDefault(router: router, interactor: interactor)
        let view = PlaybackViewDefault(presenter: presenter)
        interactor.presenter = presenter
        let module = ModuleDefault(title: "Playback", systemImage: "video", view: AnyView(view))
        return module
    }
}
