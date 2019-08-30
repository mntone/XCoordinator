//
//  PageCoordinatorDataSource-macOS.swift
//  XCoordinator
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

///
/// PageCoordinatorDataSource is a
/// [NSPageControllerDelegate](https://developer.apple.com/documentation/appkit/NSPageControllerDelegate)
/// implementation with a rather static list of pages.
///
/// It further allows looping through the given pages. When looping is active the pages are wrapped around in the given presentables array.
/// When the user navigates beyond the end of the specified pages, the pages are wrapped around by displaying the first page.
/// In analogy to that, it also wraps to the last page when navigating beyond the beginning.
///
open class PageCoordinatorDataSource: NSObject, NSPageControllerDelegate {

    // MARK: - Stored properties

    /// The pages of the `NSPageViewController` in sequential order.
    open var pages: [NSViewController]

    // MARK: - Initialization

    ///
    /// Creates a PageCoordinatorDataSource with the given pages and looping capabilities.
    ///
    /// - Parameters:
    ///     - pages:
    ///         The pages to be shown in the `UIPageViewController`.
    ///     - loop:
    ///         Whether or not the pages of the `UIPageViewController` should be in a loop,
    ///         i.e. whether a swipe to the left of the last page should result in the first page being shown
    ///         (or the last shown when swiping right on the first page)
    ///         If you specify `false` here, the user cannot swipe left on the last page and right on the first.
    ///
    public init(pages: [NSViewController]) {
        self.pages = pages
    }

    deinit {
        pages.forEach { $0.removeFromParent() }
    }

    // MARK: - Methods

    ///
    /// See [NSPageControllerDelegate](https://developer.apple.com/documentation/appkit/NSPageControllerDelegate)
    /// for further information.
    ///
    /// Return the identifier of the view controller that owns a view to display the object.
    ///
    /// - Parameters:
    ///     - pageController: The page controller.
    ///     - object: The object to display.
    ///
    /// - Returns:
    ///     Returns a string identifier for the view controller for the specified object.
    ///
    open func pageController(_ pageController: NSPageController, identifierFor object: Any) -> NSPageController.ObjectIdentifier {
        return object as! String // swiftlint:disable:this force_cast
    }

    ///
    /// See [NSPageControllerDelegate](https://developer.apple.com/documentation/appkit/NSPageControllerDelegate)
    /// for further information.
    ///
    /// Returns a view controller the page controller uses for managing the specified identifier.
    ///
    /// - Parameters:
    ///     - pageController: The page controller.
    ///     - identifier: The identifier for a view controller.
    ///
    /// - Returns:
    ///     Returns the view controller for the specified identifier.
    ///
    public func pageController(_ pageController: NSPageController,
                               viewControllerForIdentifier identifier: NSPageController.ObjectIdentifier) -> NSViewController {
        let viewController = pages[Int(identifier)!]
        viewController.view.frame = pageController.view.frame
        if viewController.parent == nil {
            viewController.view.autoresizingMask = [.width, .height]
            pageController.addChild(viewController)
        }
        return viewController
    }

    ///
    /// See [NSPageControllerDelegate](https://developer.apple.com/documentation/appkit/NSPageControllerDelegate)
    /// for further information.
    ///
    /// This message is sent when a transition animation completes.
    ///
    /// - Parameters:
    ///     - pageViewController: The page controller.
    ///
    open func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
        pageController.completeTransition()
    }
}

#endif
