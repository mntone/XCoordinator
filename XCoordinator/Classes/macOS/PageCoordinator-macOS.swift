//
//  PageCoordinator-macOS.swift
//  XCoordinator
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

///
/// PageCoordinator provides a base class for your custom coordinator with a `UIPageViewController` rootViewController.
///
/// - Note:
///     PageCoordinator sets the dataSource of the rootViewController to reflect the parameters in the initializer.
///
open class PageCoordinator<RouteType: Route>: BaseCoordinator<RouteType, PageTransition> {

    // MARK: - Stored properties

    ///
    /// The dataSource of the rootViewController.
    ///
    /// Feel free to change the pages at runtime. To reflect the changes in the rootViewController, perform a `set` transition as well.
    ///
    public let dataSource: NSPageControllerDelegate

    ///
    /// The arrangedObjects of the rootViewController.
    ///
    public let arrangedObjects: [Any]

    // MARK: - Initialization

    ///
    /// Creates a PageCoordinator with several sequential (potentially looping) pages.
    ///
    /// It further sets the current page of the rootViewController animated in the specified direction.
    ///
    /// - Note:
    ///     If you need custom configuration of the rootViewController, modify the `configuration` parameter,
    ///     since you cannot change this after the initialization.
    ///
    /// - Parameters:
    ///     - pages:
    ///         The pages of the PageCoordinator.
    ///         These can be changed later, if necessary, using the `PageCoordinator.dataSource` property.
    ///     - set:
    ///         The presentable to be shown right from the start.
    ///         This should be one of the elements of the specified pages.
    ///         If not specified, no `set` transition is triggered, which results in the first page being shown.
    ///
    public init(pages: [Presentable], index: Int = 0) {
        self.dataSource = PageCoordinatorDataSource(pages: pages.map { $0.viewController })
        self.arrangedObjects = pages.enumerated().map { "\($0.offset)" }

        super.init(initialTransition: .initial(pages: pages, index: index))
    }

    ///
    /// Creates a PageCoordinator with a custom dataSource.
    /// It further sets the currently shown page and a direction for the animation of displaying it.
    /// If you need custom configuration of the rootViewController, modify the `configuration` parameter,
    /// since you cannot change this after the initialization.
    ///
    /// - Parameters:
    ///     - dataSource:
    ///         The dataSource of the PageCoordinator.
    ///     - set:
    ///         The presentable to be shown right from the start.
    ///         This should be one of the elements of the specified pages.
    ///         If not specified, no `set` transition is triggered, which results in the first page being shown.
    ///
    public init(dataSource: NSPageControllerDelegate,
                arrangedObjects: [Any],
                index: Int = 0) {
        self.dataSource = dataSource
        self.arrangedObjects = arrangedObjects

        super.init(initialTransition: .select(index: index))
    }

    // MARK: - Overrides

    open override func generateRootViewController() -> NSPageController {
        let controller = NSPageController()
        controller.arrangedObjects = arrangedObjects
        controller.delegate = dataSource
        controller.transitionStyle = .horizontalStrip
        controller.view = NSView()
        return controller
    }
}

#endif
