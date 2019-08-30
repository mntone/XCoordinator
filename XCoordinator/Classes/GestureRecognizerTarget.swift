//
//  GestureRecognizerTarget.swift
//  XCoordinator
//
//  Created by Paul Kraft on 19.12.18.
//

import Foundation

internal protocol GestureRecognizerTarget {
    #if os(macOS)
    var gestureRecognizer: NSGestureRecognizer? { get }
    #else
    var gestureRecognizer: UIGestureRecognizer? { get }
    #endif
}

#if os(macOS)

internal class Target<GestureRecognizer: NSGestureRecognizer>: GestureRecognizerTarget {

    // MARK: - Stored properties

    private let handler: (GestureRecognizer) -> Void
    internal private(set) weak var gestureRecognizer: NSGestureRecognizer?

    // MARK: - Initialization

    init(recognizer gestureRecognizer: GestureRecognizer, handler: @escaping (GestureRecognizer) -> Void) {
        self.handler = handler
        self.gestureRecognizer = gestureRecognizer
        gestureRecognizer.target = self
        gestureRecognizer.action = #selector(handle)
    }

    // MARK: - Target actions

    @objc
    private func handle(_ gestureRecognizer: NSGestureRecognizer) {
        guard let recognizer = gestureRecognizer as? GestureRecognizer else { return }
        handler(recognizer)
    }
}

#else

internal class Target<GestureRecognizer: UIGestureRecognizer>: GestureRecognizerTarget {

    // MARK: - Stored properties

    private let handler: (GestureRecognizer) -> Void
    internal private(set) weak var gestureRecognizer: UIGestureRecognizer?

    // MARK: - Initialization

    init(recognizer gestureRecognizer: GestureRecognizer, handler: @escaping (GestureRecognizer) -> Void) {
        self.handler = handler
        self.gestureRecognizer = gestureRecognizer
        gestureRecognizer.addTarget(self, action: #selector(handle))
    }

    // MARK: - Target actions

    @objc
    private func handle(_ gestureRecognizer: UIGestureRecognizer) {
        guard let recognizer = gestureRecognizer as? GestureRecognizer else { return }
        handler(recognizer)
    }
}

#endif
