//
//  PageViewTransition.swift
//  XCoordinator
//
//  Created by Paul Kraft on 29.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

#if os(macOS)

/// PageTransition offers transitions that can be used
/// with a `NSPageController` rootViewController.
public typealias PageTransition = Transition<NSPageController>

extension Transition where RootViewController: NSPageController {

    ///
    /// Transition to select a page.
    ///
    /// - Parameters:
    ///     - index:
    ///         The index of the page to be selected. Make sure that there is a page at the specified index.
    ///
    public static func select(index: Int) -> PageTransition {
        return PageTransition(presentables: [], animationInUse: nil) { rootViewController, options, completion in
            rootViewController.select(index: index, with: options, completion: completion)
        }
    }

    static func initial(pages: [Presentable], index: Int) -> Transition {
        return Transition(presentables: pages, animationInUse: nil) { rootViewController, _, completion in
            rootViewController.selectedIndex = index
            pages.forEach { $0.presented(from: rootViewController) }
            completion?()
        }
    }
}

#else

/// PageTransition offers transitions that can be used
/// with a `UIPageViewController` rootViewController.
public typealias PageTransition = Transition<UIPageViewController>

extension Transition where RootViewController: UIPageViewController {

    ///
    /// Sets the current page(s) of the rootViewController. Make sure to set
    /// `UIPageViewController.isDoubleSided` to the appropriate setting before executing this transition.
    ///
    /// - Parameters:
    ///     - first:
    ///         The first page being shown. If second is specified as `nil`, this reflects a single page
    ///         being shown.
    ///     - second:
    ///         The second page being shown. This page is optional, as your rootViewController can be used
    ///         with `isDoubleSided` enabled or not.
    ///     - direction:
    ///         The direction in which the transition should be animated.
    ///
    public static func set(_ first: Presentable, _ second: Presentable? = nil,
                           direction: UIPageViewController.NavigationDirection) -> PageTransition {
        let presentables = [first, second].compactMap { $0 }
        return PageTransition(presentables: presentables, animationInUse: nil) { rootViewController, options, completion in
            rootViewController.set(presentables.map { $0.viewController },
                                   direction: direction,
                                   with: options
            ) {
                presentables.forEach { $0.presented(from: rootViewController) }
                completion?()
            }
        }
    }

    static func initial(pages: [Presentable]) -> Transition {
        return Transition(presentables: pages, animationInUse: nil) { rootViewController, _, completion in
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                pages.forEach { $0.presented(from: rootViewController) }
                completion?()
            }
            CATransaction.commit()
        }
    }
}

#endif
