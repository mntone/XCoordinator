//
//  NSViewControllerContextTransitioning.swift
//  XCoordinator
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

public protocol NSViewControllerContextTransitioning {

    var containerView: NSView { get }

    var fromViewController: NSViewController? { get }

    var toViewController: NSViewController? { get }

    func completeTransition()
}

struct NSViewControllerContextTransitioningImpl: NSViewControllerContextTransitioning {
    let containerView: NSView
    let fromViewController: NSViewController?
    let toViewController: NSViewController?
    let completion: PresentationHandler?

    func completeTransition() {
        completion?()
    }
}

#endif
