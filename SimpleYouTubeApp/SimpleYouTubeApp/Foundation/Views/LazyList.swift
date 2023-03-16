//
//  LazyList.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct LazyList<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            LazyVStack {
                content()
            }
            .padding()
        }
    }
}

struct LazyList_Previews: PreviewProvider {
    static var previews: some View {
        LazyList {
            EmptyState()
        }
    }
}
