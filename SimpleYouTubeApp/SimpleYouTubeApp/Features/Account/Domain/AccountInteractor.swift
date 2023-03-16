//
//  AccountInteractor.swift
//  SimpleYouTubeApp
//

import Foundation

protocol AccountInteractorDelegate: AnyObject {
    func onReceive(viewModel: AccountPendingViewModel)
    func onReceive(viewModel: AccountSuccessViewModel)
    func onError(error: Error)
}

protocol AccountInteractor: AccountRepositoryDelegate {
    func signIn()
    func signOut()
}

final class AccountInteractorDefault: AccountInteractor {
    weak var presenter: AccountInteractorDelegate?

    private let repository: AccountRepository
    private let localStorageService: LocalStorageService

    init(repository: AccountRepository, localStorageService: LocalStorageService) {
        self.repository = repository
        self.localStorageService = localStorageService
    }

    func signIn() {
        // Create DTOs
        let credentials: Account.Credentials? = localStorageService.get(forKey: "credentials")
        repository.signIn(path: "sign-in/", params: credentials != nil ? ["credentials": credentials] : [:])
    }

    func signOut() {
        repository.signOut(path: "sign-out/")
    }
}

extension AccountInteractorDefault: AccountRepositoryDelegate {
    func repository(_: AccountRepository, didReceive account: Account) {
        switch account.status {
        case .pending:
            guard let viewModel = AccountPendingViewModelDefault(account: account) else {
                return
            }
            presenter?.onReceive(viewModel: viewModel)
        case .success:
            guard let viewModel = AccountSuccessViewModelDefault(account: account), let credentials = account.credentials else {
                return
            }
            localStorageService.set(value: credentials, forKey: "credentials")
            presenter?.onReceive(viewModel: viewModel)
        }
    }

    func repository(_: AccountRepository, didReceive error: Error) {
        presenter?.onError(error: error)
    }
}
