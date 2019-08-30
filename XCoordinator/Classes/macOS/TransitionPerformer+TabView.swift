//
//  TransitionPerformer+TabView.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

extension NSTabViewController {
    func set(_ viewControllers: [NSViewController], completion: PresentationHandler?) {
        tabViewItems = viewControllers.map(NSTabViewItem.init)
        completion?()
    }

    func select(_ viewController: NSViewController, completion: PresentationHandler?) {
        let item = tabViewItem(for: viewController)!
        let index = tabViewItems.firstIndex(of: item)!
        select(index: index, completion: completion)
    }

    func select(index: Int, completion: PresentationHandler?) {
        selectedTabViewItemIndex = index
        completion?()
    }
}

#endif
