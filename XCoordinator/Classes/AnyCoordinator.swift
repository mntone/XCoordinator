//
//  AnyCoordinator.swift
//  XCoordinator
//
//  Created by Paul Kraft on 25.10.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

#if os(iOS) || os(tvOS)

/// An type-erased Coordinator (`AnyCoordinator`) with a `UINavigationController` as rootViewController.
public typealias AnyNavigationCoordinator<RouteType: Route> = AnyCoordinator<RouteType, NavigationTransition>

#endif

#if os(macOS)

/// An type-erased Coordinator (`AnyCoordinator`) with a `NSTabViewController` as rootViewController.
public typealias AnyTabBarCoordinator<RouteType: Route> = AnyCoordinator<RouteType, TabViewTransition>

#else

/// An type-erased Coordinator (`AnyCoordinator`) with a `UITabBarController` as rootViewController.
public typealias AnyTabBarCoordinator<RouteType: Route> = AnyCoordinator<RouteType, TabBarTransition>

#endif

/// An type-erased Coordinator (`AnyCoordinator`) with a `UIViewController` as rootViewController.
public typealias AnyViewCoordinator<RouteType: Route> = AnyCoordinator<RouteType, ViewTransition>

///
/// `AnyCoordinator` is a type-erased `Coordinator` (`RouteType` & `TransitionType`) and
/// can be used as an abstraction from a specific coordinator class while still specifying
/// TransitionType and RouteType.
///
/// - Note:
///     If you do not want/need to specify TransitionType, you might want to look into the `AnyRouter` class.
///     See `AnyTransitionPerformer` to further abstract from RouteType.
///
public class AnyCoordinator<RouteType: Route, TransitionType: TransitionProtocol>: Coordinator {

    // MARK: - Stored properties

    private let _prepareTransition: (RouteType) -> TransitionType
    #if os(macOS)
    private let _viewController: () -> NSViewController?
    #else
    private let _viewController: () -> UIViewController?
    #endif
    private let _rootViewController: () -> TransitionType.RootViewController
    private let _presented: (Presentable?) -> Void
    #if os(macOS)
    private let _setRoot: (NSWindow) -> Void
    #else
    private let _setRoot: (UIWindow) -> Void
    #endif

    // MARK: - Initialization

    ///
    /// Creates a type-erased Coordinator for a specific coordinator.
    ///
    /// A strong reference to the source coordinator is kept.
    ///
    /// - Parameter coordinator:
    ///     The source coordinator.
    ///
    public init<C: Coordinator>(_ coordinator: C) where C.RouteType == RouteType, C.TransitionType == TransitionType {
        self._prepareTransition = coordinator.prepareTransition
        self._viewController = { coordinator.viewController }
        self._rootViewController = { coordinator.rootViewController }
        self._presented = coordinator.presented
        self._setRoot = coordinator.setRoot
    }

    // MARK: - Computed properties

    public var rootViewController: TransitionType.RootViewController {
        return _rootViewController()
    }

    #if os(macOS)
    public var viewController: NSViewController! {
        return _viewController()
    }
    #else
    public var viewController: UIViewController! {
        return _viewController()
    }
    #endif

    // MARK: - Methods

    ///
    /// Prepare and return transitions for a given route.
    ///
    /// - Parameter route:
    ///     The triggered route for which a transition is to be prepared.
    ///
    /// - Returns:
    ///     The prepared transition.
    ///
    public func prepareTransition(for route: RouteType) -> TransitionType {
        return _prepareTransition(route)
    }

    public func presented(from presentable: Presentable?) {
        _presented(presentable)
    }

    #if os(macOS)
    public func setRoot(for window: NSWindow) {
        _setRoot(window)
    }
    #else
    public func setRoot(for window: UIWindow) {
        _setRoot(window)
    }
    #endif
}
