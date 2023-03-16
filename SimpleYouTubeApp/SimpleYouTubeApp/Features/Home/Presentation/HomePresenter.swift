//
//  HomePresenter.swift
//  SimpleYouTubeApp
//

import Combine
import Foundation

enum HomeViewState {
    case error(Error)
    case content(HomeViewModel)
    case loading
    case empty
}

protocol HomePresenter: ObservableObject {
    var viewState: HomeViewState { get }

    func onAppear()
    func onErrorRetry()
    func onRefresh()
    func onSelection(_ item: HomeItemViewModel)
}

final class HomePresenterDefault: HomePresenter {
    @Published var viewState: HomeViewState = .loading

    private let router: HomeRouter
    private let interactor: HomeInteractor

    init(router: HomeRouter, interactor: HomeInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func onAppear() {
        viewState = .loading
        interactor.getHomeViewModel()
    }

    func onErrorRetry() {
        viewState = .loading
        interactor.getHomeViewModel()
    }

    func onRefresh() {
        viewState = .loading
        interactor.getHomeViewModel()
    }

    func onSelection(_: HomeItemViewModel) {}
}

extension HomePresenterDefault: HomeInteractorDelegate {
    func onReceived(homeViewModel: HomeViewModel) {
        DispatchQueue.main.async {
            if homeViewModel.items.isEmpty {
                self.viewState = .empty
            } else {
                self.viewState = .content(homeViewModel)
            }
        }
    }

    func onError(error: Error) {
        DispatchQueue.main.async {
            debugPrint(error)
            self.viewState = .error(error)
        }
    }
}
