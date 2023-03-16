//
//  PlaybackItemViewModel.swift
//  SimpleYouTubeApp
//

import AVKit

protocol PlaybackItemViewModel {
    var player: AVPlayer { get }
}

struct PlaybackItemViewModelDefault: PlaybackItemViewModel {
    let player: AVPlayer

    private let playbackItem: PlaybackItem

    init(playbackItem: PlaybackItem) {
        self.playbackItem = playbackItem
        player = AVPlayer(url: URL(string: "https://manifest.googlevideo.com/api/manifest/hls_variant/expire/1678518313/ei/ydMLZPHTLrCPsfIPoayBQA/ip/199.204.35.15/id/3bbcc35a4576a436/source/youtube/requiressl/yes/playback_host/rr5---sn-nx5s7n7d.googlevideo.com/mh/Cb/mm/31%2C26/mn/sn-nx5s7n7d%2Csn-vgqskns7/ms/au%2Conr/mv/m/mvi/5/pl/21/hfr/1/tts_caps/1/maudio/1/initcwndbps/1098750/spc/H3gIhomLCQCNsQqLBeNok6BVuqWt3fBldv6qBpLDcBxIn_fauA/vprv/1/go/1/mt/1678496459/fvip/4/nvgoi/1/ncsapi/1/keepalive/yes/fexp/24007246/dover/11/itag/0/playlist_type/CLEAN/sparams/expire%2Cei%2Cip%2Cid%2Csource%2Crequiressl%2Chfr%2Ctts_caps%2Cmaudio%2Cspc%2Cvprv%2Cgo%2Citag%2Cplaylist_type/sig/AOq0QJ8wRAIgRD_nFPJ0d9SWs3g3W4nXRWNXWJNMTUUmoH2Jbs_l7SACIDAm6e1cN5vPw898xCaCChnDQPKkAym6zJX-7ABCFkEw/lsparams/playback_host%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps/lsig/AG3C_xAwRAIgV76NhDU7REXODLgG_TOK-KUrST8ebjcIOOPczcUgUTQCICFpmgDys8Ky0cYg0hnbYIy5ygBqy3oBWW6UTRfXq8WE/file/index.m3u8")!)
        player.play()
    }
}
