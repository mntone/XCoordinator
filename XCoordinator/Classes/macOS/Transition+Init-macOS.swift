//
//  Transition+Init-macOS.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

extension Transition {

    ///
    /// Transition to present the given presentable as popover.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///     - positioningRect: The content size of the popover.
    ///     - positioningView:
    ///         The view relative to which the popover should be positioned.
    ///         Must not be nil, or else the view controller raises an invalidArgumentException exception.
    ///     - preferredEdge: The edge of positioningView that the popover should prefer to be anchored to.
    ///     - behavior: The popover’s closing behavior. See the NSPopover.Behavior enumeration.
    ///
    public static func presentAsPopover(_ presentable: Presentable,
                                        relativeTo positioningRect: NSRect,
                                        of positioningView: NSView,
                                        preferredEdge: NSRectEdge,
                                        behavior: NSPopover.Behavior) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.presentAsPopover(presentable.viewController,
                                                relativeTo: positioningRect,
                                                of: positioningView,
                                                preferredEdge: preferredEdge,
                                                behavior: behavior
            ) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable as modal window.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///
    public static func presentAsModalWindow(_ presentable: Presentable) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.presentAsModalWindow(presentable.viewController) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable as sheet.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///
    public static func presentAsSheet(_ presentable: Presentable) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.presentAsSheet(presentable.viewController) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///     - animation:
    ///         The animation to be set as the presentable's transitioningDelegate. Specify `nil` to not override
    ///         the current transitioningDelegate and `Animation.default` to reset the transitioningDelegate to use
    ///         the default UIKit animations.
    ///
    public static func transitionOnRoot(_ presentable: Presentable, animation: NSViewController.TransitionOptions) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.transition(onRoot: true,
                                          presentable.viewController,
                                          with: animation
            ) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable. It uses the rootViewController's children.last,
    /// if present, otherwise it is equivalent to `transitionOnRoot`.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///     - animation:
    ///         The animation to be set as the presentable's transitioningDelegate. Specify `nil` to not override
    ///         the current transitioningDelegate and `Animation.default` to reset the transitioningDelegate to use
    ///         the default UIKit animations.
    ///
    public static func transition(_ presentable: Presentable, animation: NSViewController.TransitionOptions) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.transition(onRoot: false,
                                          presentable.viewController,
                                          with: animation
            ) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable on the rootViewController.
    ///
    /// The present-transition might also be helpful as it always presents on top of what is currently
    /// presented.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///     - animation:
    ///         The animation to be set as the presentable's transitioningDelegate. Specify `nil` to not override
    ///         the current transitioningDelegate and `Animation.default` to reset the transitioningDelegate to use
    ///         the default UIKit animations.
    ///
    public static func present(_ presentable: Presentable, animation: Animation = .default) -> Transition {
        return Transition(presentables: [presentable],
                          animationInUse: animation.presentationAnimation
        ) { rootViewController, options, completion in
            rootViewController.present(onTop: false,
                                       presentable.viewController,
                                       with: options,
                                       animation: animation
            ) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to present the given presentable. It uses the rootViewController's presentedViewController,
    /// if present, otherwise it is equivalent to `presentOnRoot`.
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be presented.
    ///     - animation:
    ///         The animation to be set as the presentable's transitioningDelegate. Specify `nil` to not override
    ///         the current transitioningDelegate and `Animation.default` to reset the transitioningDelegate to use
    ///         the default UIKit animations.
    ///
    public static func presentOnTop(_ presentable: Presentable, animation: Animation = .default) -> Transition {
        return Transition(presentables: [presentable],
                          animationInUse: animation.presentationAnimation
        ) { rootViewController, options, completion in
            rootViewController.present(onTop: true,
                                       presentable.viewController,
                                       with: options,
                                       animation: animation
            ) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to embed the given presentable in a specific container (i.e. a view or viewController).
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be embedded.
    ///
    public static func embedToRoot(_ presentable: Presentable) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.embedToRoot(presentable.viewController) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to embed the given presentable in a specific container (i.e. a view or viewController).
    ///
    /// - Parameters:
    ///     - presentable: The presentable to be embedded.
    ///     - container: The container to embed the presentable in.
    ///
    public static func embed(_ presentable: Presentable, in container: Container) -> Transition {
        return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, _, completion in
            rootViewController.embed(presentable.viewController, in: container) {
                presentable.presented(from: rootViewController)
                completion?()
            }
        }
    }

    ///
    /// Transition to call dismiss on the rootViewController's children.first, if present.
    ///
    public static func dismissToRoot(animation: Animation = .default) -> Transition {
        return Transition(presentables: [],
                          animationInUse: animation.dismissalAnimation
        ) { rootViewController, options, completion in
            rootViewController.dismiss(toRoot: true, with: options, animation: animation, completion: completion)
        }
    }

    ///
    /// Transition to call dismiss on the rootViewController's children.last, if present.
    ///
    public static func dismiss(animation: Animation = .default) -> Transition {
        return Transition(presentables: [],
                          animationInUse: animation.dismissalAnimation
        ) { rootViewController, options, completion in
            rootViewController.dismiss(toRoot: false, with: options, animation: animation, completion: completion)
        }
    }

    ///
    /// Transition to call dismiss on the rootViewController's presentedViewController, if present.
    ///
    public static func close() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, _, _ in
            rootViewController.close()
        }
    }

    ///
    /// No transition at all. May be useful for testing or debugging purposes, or to ignore specific
    /// routes.
    ///
    public static func none() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { _, _, completion in
            completion?()
        }
    }

    ///
    /// With this transition you can chain multiple transitions of the same type together.
    ///
    /// - Parameter transitions:
    ///     The transitions to be chained to form the new transition.
    ///
    public static func multiple<C: Collection>(_ transitions: C) -> Transition where C.Element == Transition {
        return Transition(presentables: transitions.flatMap { $0.presentables },
                          animationInUse: transitions.compactMap { $0.animation }.last
        ) { rootViewController, options, completion in
            guard let firstTransition = transitions.first else {
                completion?()
                return
            }
            firstTransition.perform(on: rootViewController, with: options) {
                let newTransitions = Array(transitions.dropFirst())
                Transition
                    .multiple(newTransitions)
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }

    ///
    /// Use this transition to trigger a route on another coordinator. TransitionOptions and
    /// PresentationHandler used during the execution of this transitions are forwarded.
    ///
    /// - Parameters:
    ///     - route: The route to be triggered on the coordinator.
    ///     - coordinator: The coordinator to trigger the route on.
    ///
    public static func route<C: Coordinator>(_ route: C.RouteType, on coordinator: C) -> Transition {
        let transition = coordinator.prepareTransition(for: route)
        return Transition(presentables: transition.presentables,
                          animationInUse: transition.animation
        ) { _, options, completion in
            coordinator.performTransition(transition, with: options, completion: completion)
        }
    }

    ///
    /// Use this transition to trigger a route on another router. TransitionOptions and
    /// PresentationHandler used during the execution of this transitions are forwarded.
    ///
    /// Peeking is not supported with this transition. If needed, use the `route` transition instead.
    ///
    /// - Parameters:
    ///     - route: The route to be triggered on the coordinator.
    ///     - router: The router to trigger the route on.
    ///
    public static func trigger<R: Router>(_ route: R.RouteType, on router: R) -> Transition {
        return Transition(presentables: [], animationInUse: nil) { _, options, completion in
            router.trigger(route, with: options, completion: completion)
        }
    }

    ///
    /// Performs a transition on a different viewController than the coordinator's rootViewController.
    ///
    /// This might be helpful when creating a coordinator for a specific viewController would create unnecessary complicated code.
    ///
    /// - Parameters:
    ///     - transition: The transition to be performed.
    ///     - viewController: The viewController to perform the transition on.
    ///
    public static func perform<TransitionType: TransitionProtocol>(_ transition: TransitionType,
                                                                   on viewController: TransitionType.RootViewController) -> Transition {
        return Transition(presentables: transition.presentables,
                          animationInUse: transition.animation
        ) { _, options, completion in
            transition.perform(on: viewController, with: options, completion: completion)
        }
    }
}

#endif
