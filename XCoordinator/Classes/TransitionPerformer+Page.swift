//
//  Coordinator+PageView.swift
//  XCoordinator
//
//  Created by Paul Kraft on 30.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

#if os(macOS)

extension NSPageController {
    func select(index: Int,
                with options: XCoordinator.TransitionOptions,
                completion: PresentationHandler?) {
        if options.animated {
            NSAnimationContext.runAnimationGroup({ _ in
                animator().selectedIndex = index
            }, completionHandler: {
                self.completeTransition()
                completion?()
            })
        } else {
            selectedIndex = index
            completion?()
        }
    }
}

#else

extension UIPageViewController {
    func set(_ viewControllers: [UIViewController],
             direction: UIPageViewController.NavigationDirection,
             with options: TransitionOptions,
             completion: PresentationHandler?) {
        setViewControllers(
            viewControllers,
            direction: direction,
            animated: options.animated,
            completion: { _ in completion?() }
        )
    }
}

#endif
