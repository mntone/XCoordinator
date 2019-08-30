//
//  Animation+Slide.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 30.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import XCoordinator

extension Animation {
    static let slide = Animation(
        presentation: StaticTransitionAnimation.slideRight,
        dismissal: StaticTransitionAnimation.slideLeft
    )
}

extension StaticTransitionAnimation {
    fileprivate static let slideRight = StaticTransitionAnimation(duration: 0.35) { transitionContext in
        let containerView = transitionContext.containerView
        let fromView = transitionContext.fromViewController?.view
        let toView = transitionContext.toViewController?.view

        let finalFromX: CGFloat
        if let fromView = fromView {
            finalFromX = -fromView.frame.size.width
            fromView.autoresizingMask = []
            fromView.frame.origin.x = 0.0
        } else {
            finalFromX = 0.0
        }

        if let toView = toView {
            toView.autoresizingMask = []
            toView.frame.origin.x = toView.frame.size.width
            containerView.addSubview(toView)
        }

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.35
            fromView?.animator().frame.origin.x = finalFromX
            toView?.animator().frame.origin.x = 0.0
        }, completionHandler: {
            fromView?.removeFromSuperview()
            toView?.autoresizingMask = [.width, .height]
            transitionContext.completeTransition()
        })
    }

    fileprivate static let slideLeft = StaticTransitionAnimation(duration: 0.35) { transitionContext in
        let containerView = transitionContext.containerView
        let fromView = transitionContext.fromViewController?.view
        let toView = transitionContext.toViewController?.view

        let fromFinalX: CGFloat
        if let fromView = fromView {
            fromFinalX = fromView.frame.size.width
            fromView.autoresizingMask = []
            fromView.frame.origin.x = 0.0

            if let toView = toView {
                toView.autoresizingMask = []
                toView.frame.origin.x = toView.frame.size.width
                containerView.addSubview(toView, positioned: .below, relativeTo: fromView)
            }
        } else {
            fromFinalX = 0.0

            if let toView = toView {
                toView.autoresizingMask = []
                toView.frame.origin.x = toView.frame.size.width
                containerView.addSubview(toView)
            }
        }

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.35
            fromView?.animator().frame.origin.x = fromFinalX
            toView?.animator().frame.origin.x = 0.0
        }, completionHandler: {
            fromView?.removeFromSuperview()
            toView?.autoresizingMask = [.width, .height]
            transitionContext.completeTransition()
        })
    }
}
