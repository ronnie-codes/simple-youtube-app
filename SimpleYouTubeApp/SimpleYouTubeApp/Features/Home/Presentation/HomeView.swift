//
//  HomeView.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct HomeViewDefault<Presenter: HomePresenter>: View {
    @StateObject var presenter: Presenter

    var body: some View {
        switch presenter.viewState {
        case let .error(error):
            ErrorState(error: error, onRetry: presenter.onErrorRetry)
        case let .content(viewModel):
            HomeGrid(viewModel: viewModel, didSelect: presenter.onSelection)
                .refreshable(action: presenter.onRefresh)
        case .empty:
            EmptyState()
        case .loading:
            ActivityIndicator(onAppear: presenter.onAppear)
        }
    }
}

private struct HomeGrid: View {
    let viewModel: HomeViewModel
    let didSelect: (HomeItemViewModel) -> Void

    let itemWidth: CGFloat = {
        #if os(tvOS)
            return 504.0
        #else
            return 336.0
        #endif
    }()

    var body: some View {
        GeometryReader { geo in
            LazyGrid(columns: [GridItem](repeating: .init(.flexible()), count: numColumns(for: geo.size.width))) {
                HomeGridSection(items: viewModel.items, didSelect: didSelect)
            }
        }
    }

    private func numColumns(for gridWidth: CGFloat) -> Int {
        max(Int(gridWidth / itemWidth), 1)
    }
}

private struct HomeGridSection: View {
    let items: [HomeItemViewModel]
    let didSelect: (HomeItemViewModel) -> Void

    var body: some View {
        Section {
            ForEach(items, id: \.id) { item in
                HomeGridItem(item: item)
            }
            .padding(8)
        }
    }
}

private struct HomeGridItem: View {
    let item: HomeItemViewModel

    var body: some View {
        CardView(
            viewModel: CardViewModelDefault(
                image: item.thumbnail,
                caption: item.duration,
                title: item.title,
                subtitle: Label(text: item.author.name),
                footer: Label(text: "\(item.viewCount.text) - \(item.published.text)")
            )
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = HomeRepositoryMock()
        let interactor = HomeInteractorDefault(repository: repository)
        let router = HomeRouterDefault()
        let presenter = HomePresenterDefault(router: router, interactor: interactor)
        let view = HomeViewDefault(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}
