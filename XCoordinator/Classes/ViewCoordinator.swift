//
//  ViewCoordinator.swift
//  XCoordinator
//
//  Created by Paul Kraft on 29.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

#if os(macOS)

///
/// ViewTransition offers transitions common to any `NSViewController` rootViewController.
///
public typealias ViewTransition = Transition<NSViewController>

#else

///
/// ViewTransition offers transitions common to any `UIViewController` rootViewController.
///
public typealias ViewTransition = Transition<UIViewController>

#endif

///
/// ViewCoordinator is a base class for custom coordinators with a `NS/UIViewController` rootViewController.
///
open class ViewCoordinator<RouteType: Route>: BaseCoordinator<RouteType, ViewTransition> {

    // MARK: - Initialization

    public override init(initialRoute: RouteType?) {
        super.init(initialRoute: initialRoute)
    }

    ///
    /// Creates a ViewCoordinator and embeds the root presentable into the rootViewController.
    ///
    /// - Parameter root:
    ///     The presentable to be embedded.
    ///
    public init(root: Presentable) {
        super.init(initialRoute: nil)
        #if os(macOS)
        performTransition(.embed(root, in: rootViewController), with: .default)
        #else
        performTransition(.embed(root, in: rootViewController), with: TransitionOptions(animated: false))
        #endif
    }

    #if os(macOS)

    // MARK: - Overrides

    open override func generateRootViewController() -> NSViewController {
        let controller = NSViewController()
        controller.view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        return controller
    }

    #endif
}
