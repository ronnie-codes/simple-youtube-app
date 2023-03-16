//
//  KeychainService.swift
//  SimpleYouTubeApp
//

import Foundation
import KeychainAccess

final class KeychainService: LocalStorageService {
    private let keychain: Keychain
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(service: String, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        keychain = Keychain(service: service)
        self.encoder = encoder
        self.decoder = decoder
    }

    init(service: String, group: String, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        keychain = Keychain(service: service, accessGroup: group)
        self.encoder = encoder
        self.decoder = decoder
    }

    func set<T>(value: T, forKey: String) where T: Codable {
        if let data = try? encoder.encode(value) {
            keychain[data: forKey] = data
        }
    }

    func get<T>(forKey: String) -> T? where T: Codable {
        if let data = keychain[data: forKey], let value = try? decoder.decode(T.self, from: data) {
            return value
        }
        return nil
    }

    func remove(forKey: String) {
        keychain[forKey] = nil
    }
}
