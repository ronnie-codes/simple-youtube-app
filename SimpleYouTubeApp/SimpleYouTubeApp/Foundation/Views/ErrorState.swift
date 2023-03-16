//
//  ErrorState.swift
//  SwiftySeatGeek
//

import SwiftUI

struct ErrorState: View {
    let error: Error
    let onRetry: () -> Void

    var body: some View {
        GeometryReader { view in
            VStack(alignment: .center, spacing: 5) {
                Text("Something went wrong.")
                    .font(.title)
                Text(error.localizedDescription)
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                Button("Retry", action: onRetry)
                    .font(.title3)
                    .padding()
            }
            .padding()
            .position(x: view.frame(in: .local).midX,
                      y: view.frame(in: .local).midY)
        }
    }
}

struct ErrorState_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            let error = NSError(domain: "", code: -1, userInfo: [:])
            ErrorState(error: error, onRetry: {})
                .padding(.top)
                .padding(.top)
                .padding(.top)
        }
    }
}
