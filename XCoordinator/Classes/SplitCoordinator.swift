//
//  SplitCoordinator.swift
//  XCoordinator
//
//  Created by Paul Kraft on 30.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

///
/// SplitCoordinator can be used as a basis for a coordinator with a rootViewController of type
/// `UISplitViewController`.
///
/// You can use all `SplitTransitions` and get an initializer to set a master and
/// (optional) detail presentable.
///
open class SplitCoordinator<RouteType: Route>: BaseCoordinator<RouteType, SplitTransition> {

    // MARK: - Initialization

    public override init(initialRoute: RouteType?) {
        super.init(initialRoute: initialRoute)
    }

    #if os(macOS)

    ///
    /// Creates a SplitCoordinator with a specified set of sections.
    ///
    /// - Parameter tabs:
    ///     The presentables to be used as sections.
    ///
    public init(sections: [Presentable]) {
        super.init(initialTransition: .set(sections))
    }

    #else

    ///
    /// Creates a SplitCoordinator and sets the specified presentables as the rootViewController's
    /// viewControllers.
    ///
    /// - Parameters:
    ///     - master:
    ///         The presentable to be shown as master in the `UISplitViewController`.
    ///     - detail:
    ///         The presentable to be shown as detail in the `UISplitViewController`. This is optional due to
    ///         the fact that it might not be useful to have a detail page right away on a small-screen device.
    ///
    public init(master: Presentable, detail: Presentable?) {
        super.init(initialTransition: .set([master, detail].compactMap { $0 }))
    }

    #endif
}
