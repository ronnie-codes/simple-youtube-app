//
//  HomeItemViewModel.swift
//  SimpleYouTubeApp
//

protocol HomeItemViewModel {
    var id: String { get }
    var title: Label { get }
    var viewCount: Label { get }
    var duration: Label { get }
    var published: Label { get }
    var thumbnail: Thumbnail { get }
    var author: Author { get }
}

struct HomeItemViewModelDefault: HomeItemViewModel {
    let id: String
    let title: Label
    let viewCount: Label
    let duration: Label
    let published: Label
    let thumbnail: Thumbnail
    let author: Author

    init?(item: Home.Content.Item?) {
        guard let id = item?.id,
              let title = item?.title,
              let viewCount = item?.shortViewCount,
              let duration = item?.duration,
              let published = item?.published,
              let thumbnail = item?.thumbnails?.first,
              let author = item?.author
        else {
            return nil
        }
        self.id = id
        self.title = title
        self.viewCount = viewCount
        self.duration = duration
        self.published = published
        self.thumbnail = thumbnail
        self.author = author
    }
}
