//
//  Animation+Fade.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 30.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import XCoordinator

extension Animation {
    static let fade = Animation(
        presentation: StaticTransitionAnimation.fade,
        dismissal: StaticTransitionAnimation.fade
    )
}

extension StaticTransitionAnimation {
    fileprivate static let fade = StaticTransitionAnimation(duration: 0.35) { transitionContext in
        let containerView = transitionContext.containerView
        let fromView = transitionContext.fromViewController?.view
        let toView = transitionContext.toViewController?.view

        toView?.alphaValue = 0.0
        toView.map(containerView.addSubview)

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.35
            fromView?.animator().alphaValue = 0.0
            toView?.animator().alphaValue = 1.0
        }, completionHandler: {
            fromView?.removeFromSuperview()
            transitionContext.completeTransition()
        })
    }
}
