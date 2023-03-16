//
//  VisionService.swift
//  SimpleYouTubeApp
//

import CoreImage
import Foundation
import Vision

protocol VisionService {
    func getText(from image: CIImage) async throws -> [String]
    func getText(from imageUrl: URL) async throws -> [String]
}

final class VisionServiceDefault: VisionService {
    private let topCandidates = 1

    func getText(from image: CIImage) async throws -> [String] {
        try await request(with: VNImageRequestHandler(ciImage: image))
    }

    func getText(from imageUrl: URL) async throws -> [String] {
        try await request(with: VNImageRequestHandler(url: imageUrl))
    }

    private func request(with handler: VNImageRequestHandler) async throws -> [String] {
        try await withCheckedThrowingContinuation { [topCandidates] continuation in
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let observations = request.results as? [VNRecognizedTextObservation] {
                    let words = observations.compactMap { $0.topCandidates(topCandidates).first?.string }
                    continuation.resume(returning: words)
                } else {
                    continuation.resume(returning: [])
                }
            }
            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
