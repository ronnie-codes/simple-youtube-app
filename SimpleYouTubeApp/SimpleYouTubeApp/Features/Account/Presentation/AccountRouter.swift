//
//  AccountRouter.swift
//  SimpleYouTubeApp
//

import Foundation
import SwiftUI

protocol AccountRouter {
    static func createModule() -> Module
}

final class AccountRouterDefault: AccountRouter {
    static func createModule() -> Module {
        let serverUrl = URL(string: Bundle.main.value(for: .serverURL)!)!
        let encoder = JSONEncoder.snakeCase
        let decoder = JSONDecoder.snakeCase
        let restNetwork = AlamofireNetwork(serverURL: serverUrl, encoder: encoder, decoder: decoder)
        let sseNetwork = SwiftEventSourceNetwork(serverURL: serverUrl.appendingPathComponent("sse/"), decoder: decoder)
        let repository = AccountRepositoryDefault(restNetwork: restNetwork, sseNetwork: sseNetwork)
        let localStorageService = KeychainService(service: "com.ronniev.nicetube.credentials", encoder: encoder, decoder: decoder)
        let interactor = AccountInteractorDefault(repository: repository, localStorageService: localStorageService)
        let router = AccountRouterDefault()
        let presenter = AccountPresenterDefault(router: router, interactor: interactor)
        let view = AccountViewDefault(presenter: presenter)
        interactor.presenter = presenter
        repository.delegate = interactor
        return ModuleDefault(title: R.string.localizable.accountTitle(), systemImage: "person.crop.circle", view: AnyView(view))
    }
}
