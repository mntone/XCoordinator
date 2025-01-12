//
//  RxTableViewDataSourceType.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

import AppKit
import RxSwift

/// Marks data source as `NSTableView` reactive data source enabling it to be used with one of the `bindTo` methods.
public protocol RxTableViewDataSourceType /*: NSTableViewDataSource*/ {

    /// Type of elements that can be bound to table view.
    associatedtype Element

    /// New observable sequence event observed.
    ///
    /// - parameter tableView: Bound table view.
    /// - parameter observedEvent: Event
    func tableView(_ tableView: NSTableView, observedEvent: Event<Element>)
}

#endif
