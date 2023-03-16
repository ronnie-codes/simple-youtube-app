//
//  AccountRepository.swift
//  SimpleYouTubeApp
//

protocol AccountRepository {
    func signIn<Parameters: Encodable>(path: String, params: Parameters)
    func signOut(path: String)
}

protocol AccountRepositoryDelegate: AnyObject {
    func repository(_ repository: AccountRepository, didReceive account: Account)
    func repository(_ repository: AccountRepository, didReceive error: Error)
}
