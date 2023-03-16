//
//  HomeInteractor.swift
//  SimpleYouTubeApp
//

protocol HomeInteractorDelegate: AnyObject {
    func onReceived(homeViewModel: HomeViewModel)
    func onError(error: Error)
}

protocol HomeInteractor {
    func getHomeViewModel()
}

final class HomeInteractorDefault: HomeInteractor {
    weak var presenter: HomeInteractorDelegate?

    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func getHomeViewModel() {
        Task {
            do {
                let home = try await repository.getHome()
                presenter?.onReceived(homeViewModel: HomeViewModelDefault(home: home))
            } catch {
                presenter?.onError(error: error)
            }
        }
    }
}
