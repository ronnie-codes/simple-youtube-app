//
//  KeychainService.swift
//  SimpleYouTubeApp
//

import Foundation

protocol LocalStorageService {
    func set<T>(value: T, forKey: String) where T: Codable
    func get<T>(forKey: String) -> T? where T: Codable
    func remove(forKey: String)
}

final class LocalStorageServiceMock: LocalStorageService {
    func set<T>(value _: T, forKey _: String) where T: Codable {}
    func get<T>(forKey _: String) -> T? where T: Codable { nil }
    func remove(forKey _: String) {}
}
