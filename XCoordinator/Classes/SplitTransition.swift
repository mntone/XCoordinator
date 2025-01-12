//
//  SplitTransition.swift
//  XCoordinator
//
//  Created by Paul Kraft on 10.01.19.
//

#if os(macOS)

///
/// SplitTransition offers different transitions common to a `NSSplitViewController` rootViewController.
///
public typealias SplitTransition = Transition<NSSplitViewController>

extension Transition where RootViewController: NSSplitViewController {
    static func set(_ presentables: [Presentable]) -> Transition {
        return Transition(presentables: presentables, animationInUse: nil) { rootViewController, _, completion in
            rootViewController.splitViewItems = presentables.map { NSSplitViewItem(viewController: $0.viewController) }
            presentables.forEach { $0.presented(from: rootViewController) }
            completion?()
        }
    }
}

#else

///
/// SplitTransition offers different transitions common to a `UISplitViewController` rootViewController.
///
public typealias SplitTransition = Transition<UISplitViewController>

extension Transition where RootViewController: UISplitViewController {
    static func set(_ presentables: [Presentable]) -> Transition {
        return Transition(presentables: presentables, animationInUse: nil) { rootViewController, _, completion in
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                presentables.forEach { $0.presented(from: rootViewController) }
                completion?()
            }
            rootViewController.viewControllers = presentables.map { $0.viewController }
            CATransaction.commit()
        }
    }
}

#endif
