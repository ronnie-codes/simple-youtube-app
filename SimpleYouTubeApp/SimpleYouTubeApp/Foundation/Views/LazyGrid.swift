//
//  LazyGrid.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct LazyGrid<Content: View>: View {
    let columns: [GridItem]
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                content()
            }
            .padding()
        }
    }
}
