//
//  AccountPresenter.swift
//  SimpleYouTubeApp
//

import Combine
import Foundation

enum AccountViewState {
    case loading
    case pending(AccountPendingViewModel)
    case success(AccountSuccessViewModel)
    case error(Error)
}

protocol AccountPresenter: ObservableObject {
    var viewState: AccountViewState { get }

    func onAppear()
    func onErrorRetry()
    func onRefresh()
}

final class AccountPresenterDefault: AccountPresenter {
    @Published var viewState: AccountViewState = .loading

    private let router: AccountRouter
    private let interactor: AccountInteractor

    init(router: AccountRouter, interactor: AccountInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func onAppear() {
        viewState = .loading
        interactor.signIn()
    }

    func onErrorRetry() {
        viewState = .loading
        interactor.signIn()
    }

    func onRefresh() {
        viewState = .loading
        interactor.signIn()
    }
}

extension AccountPresenterDefault: AccountInteractorDelegate {
    func onReceive(viewModel: AccountPendingViewModel) {
        DispatchQueue.main.async {
            self.viewState = .pending(viewModel)
        }
    }

    func onReceive(viewModel: AccountSuccessViewModel) {
        DispatchQueue.main.async {
            self.viewState = .success(viewModel)
        }
    }

    func onError(error: Error) {
        debugPrint(error)
        DispatchQueue.main.async {
            self.viewState = .error(error)
        }
    }
}
