//
//  PlaybackPresenter.swift
//  SimpleYouTubeApp
//

import Combine
import Foundation

enum PlaybackViewState {
    case loading
    case content(PlaybackItemViewModel)
    case error(Error)
}

protocol PlaybackPresenter: ObservableObject {
    var viewState: PlaybackViewState { get }

    func onAppear()
    func onErrorRetry()
    func onRefresh()
}

final class PlaybackPresenterDefault: PlaybackPresenter {
    @Published var viewState: PlaybackViewState = .loading

    private let router: PlaybackRouter
    private let interactor: PlaybackInteractor

    init(router: PlaybackRouter, interactor: PlaybackInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func onAppear() {
        getPlaybackItemViewModel()
    }

    func onErrorRetry() {
        getPlaybackItemViewModel()
    }

    func onRefresh() {
        getPlaybackItemViewModel()
    }

    private func getPlaybackItemViewModel() {
        viewState = .loading
        interactor.getPlaybackItemViewModel()
    }
}

extension PlaybackPresenterDefault: PlaybackInteractorDelegate {
    func onReceived(playbackItemViewModel: PlaybackItemViewModel) {
        DispatchQueue.main.async {
            self.viewState = .content(playbackItemViewModel)
        }
    }

    func onError(error: Error) {
        debugPrint(error)
        DispatchQueue.main.async {
            self.viewState = .error(error)
        }
    }
}
