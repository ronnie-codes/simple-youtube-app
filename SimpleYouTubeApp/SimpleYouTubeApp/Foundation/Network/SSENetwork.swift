//
//  SSENetwork.swift
//  SimpleYouTubeApp
//

import Foundation
import LDSwiftEventSource

struct SSEMessage {
    let data: any Decodable
}

protocol SSENetworkDelegate: AnyObject {
    func network(_ network: SSENetwork, didReceive message: SSEMessage)
    func network(_ network: SSENetwork, didReceive error: Error)
}

protocol SSENetwork {
    func subscribe(delegate: SSENetworkDelegate, forType type: Decodable.Type)
    func unsubscribe(delegate: SSENetworkDelegate)
}

final class SwiftEventSourceNetwork: SSENetwork {
    private let serverURL: URL
    private let decoder: JSONDecoder

    private weak var delegate: SSENetworkDelegate?
    private var dataType: Decodable.Type?

    private lazy var eventSource: EventSource = {
        var config = EventSource.Config(handler: self, url: serverURL)
        config.idleTimeout = Date.distantFuture.timeIntervalSince1970
        return EventSource(config: config)
    }()

    init(serverURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.serverURL = serverURL
        self.decoder = decoder
    }

    func subscribe(delegate: SSENetworkDelegate, forType type: Decodable.Type) {
        self.delegate = delegate
        dataType = type
        eventSource.start()
    }

    func unsubscribe(delegate _: SSENetworkDelegate) {
        delegate = nil
        eventSource.stop()
    }
}

extension SwiftEventSourceNetwork: EventHandler {
    func onOpened() {
        debugPrint("SSE Stream Opened.")
    }

    func onClosed() {
        debugPrint("SSE Stream Closed.")
    }

    func onMessage(eventType: String, messageEvent: LDSwiftEventSource.MessageEvent) {
        debugPrint("SSE Message Received", eventType, messageEvent)
        guard let type = dataType, let eventType = SSEEventType(rawValue: eventType) else {
            return
        }
        do {
            switch eventType {
            case .message:
                let data = Data(messageEvent.data.utf8)
                let decodable = try decoder.decode(type, from: data)
                let sseMessage = SSEMessage(data: decodable)
                delegate?.network(self, didReceive: sseMessage)
            case .error:
                throw NSError(domain: messageEvent.data, code: -1)
            }
        } catch {
            delegate?.network(self, didReceive: error)
        }
    }

    func onComment(comment: String) {
        debugPrint("SSE Comment Received", comment)
    }

    func onError(error: Error) {
        debugPrint("SSE Error Received", error)
        delegate?.network(self, didReceive: error)
    }
}

private enum SSEEventType: String {
    case message
    case error
}
