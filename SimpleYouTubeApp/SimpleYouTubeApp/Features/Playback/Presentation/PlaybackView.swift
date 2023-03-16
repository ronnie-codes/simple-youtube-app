//
//  PlaybackView.swift
//  SimpleYouTubeApp
//

import AVKit
import SwiftUI

struct PlaybackViewDefault<Presenter: PlaybackPresenter>: View {
    @StateObject var presenter: Presenter

    var body: some View {
        switch presenter.viewState {
        case let .error(error):
            ErrorState(error: error, onRetry: presenter.onErrorRetry)
        case let .content(viewModel):
            PlaybackContent(viewModel: viewModel)
        case .loading:
            ActivityIndicator(onAppear: presenter.onAppear)
        }
    }
}

private struct PlaybackContent: View {
    let viewModel: PlaybackItemViewModel

    var body: some View {
        LazyList {
            PlaybackVideoCard(viewModel: viewModel)
            PlaybackControlBar()
            PlaybackDescriptionCard()
            PlaybackCommentsList()
            PlaybackWatchNextList()
        }
    }
}

private struct PlaybackVideoCard: View {
    let viewModel: PlaybackItemViewModel

    var body: some View {
        VideoPlayer(player: viewModel.player)
            .aspectRatio(16 / 9, contentMode: .fit)
    }
}

private struct PlaybackControlBar: View {
    var body: some View {
        HStack {
            Text("Control")
            Text("Control")
            Text("Control")
            Text("Control")
        }
    }
}

private struct PlaybackDescriptionCard: View {
    var body: some View {
        Text("Description")
    }
}

private struct PlaybackCommentsList: View {
    var body: some View {
        LazyVStack {
            EmptyState()
        }
    }
}

private struct PlaybackWatchNextList: View {
    var body: some View {
        LazyVStack {
            EmptyState()
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = PlaybackRepositoryMock()
        let interactor = PlaybackInteractorDefault(repository: repository)
        let router = PlaybackRouterDefault()
        let presenter = PlaybackPresenterDefault(router: router, interactor: interactor)
        let view = PlaybackViewDefault(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}
