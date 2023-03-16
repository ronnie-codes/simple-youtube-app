//
//  SimpleYouTubeApp.swift
//  SimpleYouTubeApp
//

import SwiftUI

@main
struct SimpleYouTubeApp: App {
    var body: some Scene {
        WindowGroup {
            ModuleContainer(modules: [
                AccountRouterDefault.createModule(),
                HomeRouterDefault.createModule(),
            ])
        }
    }
}
