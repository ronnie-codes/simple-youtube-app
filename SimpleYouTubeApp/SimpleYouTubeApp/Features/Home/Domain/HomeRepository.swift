//
//  HomeRepository.swift
//  SimpleYouTubeApp
//

import Foundation

protocol HomeRepository: AnyObject {
    func getHome() async throws -> Home
}
