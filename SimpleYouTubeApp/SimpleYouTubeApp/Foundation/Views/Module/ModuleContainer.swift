//
//  ModuleContainer.swift
//  SimpleYouTubeApp
//

import SwiftUI

struct ModuleContainer: View {
    let modules: [Module]

    var body: some View {
        MasterDetail(modules: modules)
    }
}

struct ModuleContainer_Previews: PreviewProvider {
    static var previews: some View {
        ModuleContainer(modules: [
            HomeRouterDefault.createModule(),
        ])
    }
}
