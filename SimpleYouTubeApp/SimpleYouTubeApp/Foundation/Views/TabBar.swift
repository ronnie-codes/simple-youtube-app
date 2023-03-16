//
//  TabBar.swift
//  SimpleYouTubeApp
//

import SwiftUI

// TODO: Fix
struct TabBar: View {
    @State private var selection: UUID?

    let modules: [Module]

    var body: some View {
        TabView(selection: $selection) {
            TabList(modules: modules, selection: $selection)
        }
    }
}

private struct TabList: View {
    let modules: [Module]

    @Binding var selection: UUID?

    var body: some View {
        ForEach(modules, id: \.id) { module in
            TabItem(module: module)
        }
    }
}

private struct TabItem: View {
    let module: Module

    var body: some View {
        module.view.tabItem {
            SwiftUI.Label(module.title, systemImage: module.systemImage)
        }
    }
}
