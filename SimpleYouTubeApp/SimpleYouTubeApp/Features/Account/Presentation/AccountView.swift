//
//  AccountView.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct AccountViewDefault<Presenter: AccountPresenter>: View {
    @StateObject var presenter: Presenter

    var body: some View {
        switch presenter.viewState {
        case .loading:
            ActivityIndicator(onAppear: presenter.onAppear)
        case let .pending(viewModel):
            AccountPendingView(viewModel: viewModel)
        case let .success(viewModel):
            AccountSuccessView(viewModel: viewModel)
        case let .error(error):
            ErrorState(error: error, onRetry: presenter.onErrorRetry)
        }
    }
}

private struct AccountPendingView: View {
    let viewModel: AccountPendingViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.code)
                .textSelection(.enabled)
            Link(destination: viewModel.url) {
                Text(viewModel.url.absoluteString)
            }
        }
        .font(.title)
        .textSelection(.enabled)
    }
}

private struct AccountSuccessView: View {
    let viewModel: AccountSuccessViewModel

    var body: some View {
        Text(viewModel.message)
            .font(.title)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let restNetwork = FoundationNetwork(serverURL: URL(string: "")!)
        let sseNetwork = SwiftEventSourceNetwork(serverURL: URL(string: "")!)
        let localStorageService = LocalStorageServiceMock()
        let repository = AccountRepositoryDefault(restNetwork: restNetwork, sseNetwork: sseNetwork)
        let interactor = AccountInteractorDefault(repository: repository, localStorageService: localStorageService)
        let router = AccountRouterDefault()
        let presenter = AccountPresenterDefault(router: router, interactor: interactor)
        let view = AccountViewDefault(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}
