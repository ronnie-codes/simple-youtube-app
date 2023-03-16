//
//  HomeRouter.swift
//  SimpleYouTubeApp
//

import Foundation
import SwiftUI

protocol HomeRouter {
    static func createModule() -> Module

    func showDetail(for item: HomeItemViewModel) -> Module
}

final class HomeRouterDefault: HomeRouter {
    static func createModule() -> Module {
        let network = AlamofireNetwork(serverURL: URL(string: Bundle.main.value(for: .serverURL)!)!, decoder: JSONDecoder.snakeCase)
        let repository = HomeRepositoryDefault(network: network, path: "home-feed/")
        let interactor = HomeInteractorDefault(repository: repository)
        let router = HomeRouterDefault()
        let presenter = HomePresenterDefault(router: router, interactor: interactor)
        interactor.presenter = presenter
        let view = HomeViewDefault(presenter: presenter)
        return ModuleDefault(title: R.string.localizable.homeTitle(), systemImage: "house", view: AnyView(view))
    }

    func showDetail(for item: HomeItemViewModel) -> Module {
        PlaybackRouterDefault.createModule(playbackId: item.id)
    }
}
