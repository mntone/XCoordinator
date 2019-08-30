//
//  TabViewTransition.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

/// TabBarTransition offers transitions that can be used
/// with a `UITabBarController` rootViewController.
public typealias TabViewTransition = Transition<NSTabViewController>

extension Transition where RootViewController: NSTabViewController {

    ///
    /// Transition to set the tabs of the rootViewController with an optional custom animation.
    ///
    /// - Note:
    ///     Only the presentation animation of the Animation object is used.
    ///
    /// - Parameters:
    ///     - presentables:
    ///         The tabs to be set are defined by the presentables' viewControllers.
    ///
    public static func set(_ presentables: [Presentable]) -> Transition {
        return Transition(presentables: presentables, animationInUse: nil) { rootViewController, _, completion in
            rootViewController.set(presentables.map { $0.viewController },
                                   completion: {
                                    presentables.forEach { $0.presented(from: rootViewController) }
                                    completion?()
            })
        }
    }

    ///
    /// Transition to select a tab with an optional custom animation.
    ///
    /// - Note:
    ///     Only the presentation animation of the Animation object is used.
    ///
    /// - Parameters:
    ///     - presentable:
    ///         The tab to be selected is the presentable's viewController. Make sure that this is one of the
    ///         previously specified tabs of the rootViewController.
    ///
    public static func select(_ presentable: Presentable) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.select(presentable.viewController,
                                      completion: completion)
        }
    }

    ///
    /// Transition to select a tab with an optional custom animation.
    ///
    /// - Note:
    ///     Only the presentation animation of the Animation object is used.
    ///
    /// - Parameters:
    ///     - index:
    ///         The index of the tab to be selected. Make sure that there is a tab at the specified index.
    ///
    public static func select(index: Int) -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.select(index: index,
                                      completion: completion)
        }
    }
}

#endif
