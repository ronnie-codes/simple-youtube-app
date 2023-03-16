//
//  Module.swift
//  SimpleYouTubeApp
//

import Foundation
import SwiftUI

protocol Module {
    var id: UUID { get }
    var title: String { get }
    var systemImage: String { get }
    var view: AnyView { get }
}

struct ModuleDefault: Module {
    let id: UUID = .init()
    let title: String
    let systemImage: String
    let view: AnyView
}
