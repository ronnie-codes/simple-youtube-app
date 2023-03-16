//
//  CardView.swift
//  SimpleYouTubeApp
//

import CachedAsyncImage
import SwiftUI

struct CardView<ViewModel: CardViewModel>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            thumbnail
            headline
            subheadlines
            Spacer()
        }
    }

    var thumbnail: some View {
        ZStack(alignment: .bottomTrailing) {
            CachedAsyncImage(url: viewModel.image.url) { image in
                image.resizable()
            } placeholder: {
                ActivityIndicator()
            }
            .cornerRadius(12)

            caption
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .padding(.bottom, 4)
    }

    var caption: some View {
        Text(viewModel.caption.text)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 4)
            .background(Color.black)
            .padding(4)
            .cornerRadius(4)
    }

    var headline: some View {
        Text(viewModel.title.text)
            .font(.headline)
            .foregroundColor(.primary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 4)
    }

    var subheadlines: some View {
        VStack(alignment: .leading) {
            Text(viewModel.subtitle.text)
            Text(viewModel.footer.text)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: CardViewModelMock())
            .frame(width: 336)
    }
}
