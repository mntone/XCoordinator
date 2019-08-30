//
//  TabViewCoordinator.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

///
/// Use a TabViewCoordinator to coordinate a flow where a `NSTabViewController` serves as a rootViewController.
/// With a TabViewCoordinator, you get access to all tabbarController-related transitions.
///
open class TabViewCoordinator<RouteType: Route>: BaseCoordinator<RouteType, TabViewTransition> {

    // MARK: - Initialization

    public override init(initialRoute: RouteType?) {
        super.init(initialRoute: initialRoute)
    }

    ///
    /// Creates a TabBarCoordinator with a specified set of tabs.
    ///
    /// - Parameter tabs:
    ///     The presentables to be used as tabs.
    ///
    public init(tabs: [Presentable]) {
        super.init(initialTransition: .set(tabs))
    }

    ///
    /// Creates a TabBarCoordinator with a specified set of tabs and selects a specific presentable.
    ///
    /// - Parameters:
    ///     - tabs: The presentables to be used as tabs.
    ///     - select:
    ///         The presentable to be selected before displaying. Make sure, this presentable is one of the
    ///         specified tabs in the other parameter.
    ///
    public init(tabs: [Presentable], select: Presentable) {
        super.init(initialTransition: .multiple(.set(tabs), .select(select)))
    }

    ///
    /// Creates a TabBarCoordinator with a specified set of tabs and selects a presentable at a given index.
    ///
    /// - Parameters:
    ///     - tabs: The presentables to be used as tabs.
    ///     - select: The index of the presentable to be selected before displaying.
    ///
    public init(tabs: [Presentable], select: Int) {
        super.init(initialTransition: .multiple(.set(tabs), .select(index: select)))
    }
}

#endif
