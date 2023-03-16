//
//  MasterDetailView.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct MasterDetail: View {
    @State private var selection: UUID?

    let modules: [Module]

    var body: some View {
        NavigationSplitView(
            sidebar: {
                Master(modules: modules, selection: $selection)
            },
            detail: {
                if let selection = selection {
                    Detail(module: modules.first(where: { $0.id == selection }))
                } else {
                    Text(R.string.localizable.sharedGreeting())
                }
            }
        )
        .background(EmptyView().blur(radius: 20))
    }
}

private struct Master: View {
    let modules: [Module]

    @Binding var selection: UUID?

    var body: some View {
        List(modules, id: \.id, selection: $selection) { item in
            SwiftUI.Label(item.title, systemImage: item.systemImage)
        }
    }
}

private struct Detail: View {
    let module: Module?

    var body: some View {
        module?.view
    }
}

struct MasterDetail_Previews: PreviewProvider {
    static var previews: some View {
        MasterDetail(modules: [
            AccountRouterDefault.createModule(),
            HomeRouterDefault.createModule(),
        ])
    }
}
