//
//  AccountRepositoryDefault.swift
//  SimpleYouTubeApp
//

import Foundation

final class AccountRepositoryDefault: AccountRepository {
    private let restNetwork: RESTNetwork
    private let sseNetwork: SSENetwork

    weak var delegate: AccountRepositoryDelegate?

    init(restNetwork: RESTNetwork, sseNetwork: SSENetwork) {
        self.restNetwork = restNetwork
        self.sseNetwork = sseNetwork
        self.sseNetwork.subscribe(delegate: self, forType: Account.self)
    }

    func signIn<Parameters: Encodable>(path: String, params: Parameters) {
        Task {
            do {
                let _ = try await restNetwork.request(method: .post, path: path, params: params) as Empty
            } catch {
                debugPrint(error)
            }
        }
    }

    func signOut(path: String) {
        Task {
            do {
                let _ = try await restNetwork.request(method: .post, path: path) as Empty
            } catch {
                debugPrint(error)
            }
        }
    }
}

extension AccountRepositoryDefault: SSENetworkDelegate {
    func network(_: SSENetwork, didReceive message: SSEMessage) {
        guard let account = message.data as? Account else {
            return
        }
        delegate?.repository(self, didReceive: account)
    }

    func network(_: SSENetwork, didReceive error: Error) {
        delegate?.repository(self, didReceive: error)
    }
}
