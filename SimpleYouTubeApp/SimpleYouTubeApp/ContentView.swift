//
//  ContentView.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            /*@START_MENU_TOKEN@*/Text("Sidebar")/*@END_MENU_TOKEN@*/
        } detail: {
            NavigationStack {
                ScrollView {
                    Grid {
                        ForEach(0 ..< 3) { _ in
                            GridRow {
                                ForEach(0 ..< 3) { _ in
                                    GridCell()
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            .navigationTitle("Home")
        }
    }
}

private struct GridCell: View {
    var body: some View {
        Color
            .primary
            .frame(width: 100, height: 80)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
