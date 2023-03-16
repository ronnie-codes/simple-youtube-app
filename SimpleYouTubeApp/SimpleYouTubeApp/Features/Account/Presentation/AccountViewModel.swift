//
//  AccountPendingViewModel.swift
//  SimpleYouTubeApp
//

import Foundation

protocol AccountPendingViewModel {
    var code: String { get }
    var url: URL { get }
}

struct AccountPendingViewModelDefault: AccountPendingViewModel {
    let code: String
    let url: URL

    init?(account: Account) {
        guard let data = account.data else {
            return nil
        }
        code = data.userCode
        url = data.verificationUrl
    }
}

protocol AccountSuccessViewModel {
    var message: String { get }
}

struct AccountSuccessViewModelDefault: AccountSuccessViewModel {
    let message: String = R.string.localizable.accountSuccessMessage() // this message should come from server

    init?(account: Account) {
        guard account.status == .success else {
            return nil
        }
    }
}
