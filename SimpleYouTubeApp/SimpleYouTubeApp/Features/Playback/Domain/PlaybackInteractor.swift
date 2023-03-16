//
//  PlaybackInteractor.swift
//  SimpleYouTubeApp
//

protocol PlaybackInteractorDelegate: AnyObject {
    func onReceived(playbackItemViewModel: PlaybackItemViewModel)
    func onError(error: Error)
}

protocol PlaybackInteractor {
    func getPlaybackItemViewModel()
}

final class PlaybackInteractorDefault: PlaybackInteractor {
    weak var presenter: PlaybackInteractorDelegate?

    private let repository: PlaybackRepository

    init(repository: PlaybackRepository) {
        self.repository = repository
    }

    func getPlaybackItemViewModel() {
        Task {
            do {
                let item = try await repository.getPlaybackItem()
                let viewModel = PlaybackItemViewModelDefault(playbackItem: item)
                presenter?.onReceived(playbackItemViewModel: viewModel)
            } catch {
                presenter?.onError(error: error)
            }
        }
    }
}
