//
//  CardViewModel.swift
//  SimpleYouTubeApp
//

import Foundation

protocol CardViewModel {
    var layout: Layout { get }
    var size: Size { get }
    var image: Thumbnail { get }
    var caption: Label { get }
    var title: Label { get }
    var subtitle: Label { get }
    var footer: Label { get }
}

struct CardViewModelDefault: CardViewModel {
    let layout: Layout
    let size: Size
    let image: Thumbnail
    let caption: Label
    let title: Label
    let subtitle: Label
    let footer: Label

    init(layout: Layout = .vertical, size: Size = .medium, image: Thumbnail, caption: Label, title: Label, subtitle: Label, footer: Label) {
        self.layout = layout
        self.size = size
        self.image = image
        self.caption = caption
        self.title = title
        self.subtitle = subtitle
        self.footer = footer
    }
}

struct CardViewModelMock: CardViewModel {
    let layout: Layout
    let size: Size
    let image: Thumbnail
    let title: Label
    let subtitle: Label
    let footer: Label
    let caption: Label

    init() {
        layout = .vertical
        size = .medium
        let imageString = "https://i.ytimg.com/vi/Ry_3icwd68o/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDxFdueq3h_OeVh3UZi7ZZXtJE5lw"
        image = Thumbnail(url: URL(string: imageString)!, width: 480, height: 270)
        title = Label(text: "Former FBI agent: Idaho suspect’s change in demeanor ‘concerning’ | NewsNation Prime")
        subtitle = Label(text: "NewsNation")
        footer = Label(text: "4.1K views - 49 minutes ago")
        caption = Label(text: "4:24")
    }
}
