//
//  RxTableViewDelegateProxy.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

import AppKit
import RxCocoa
import RxSwift

extension NSTableView: HasDelegate {
    public typealias Delegate = NSTableViewDelegate
}

/// For more information take a look at `DelegateProxyType`.
open class RxTableViewDelegateProxy: DelegateProxy<NSTableView, NSTableViewDelegate>, DelegateProxyType, NSTableViewDelegate {

    /// Typed parent object.
    public weak private(set) var tableView: NSTableView?

    /// - parameter tableView: Parent object for delegate proxy.
    public init(tableView: NSTableView) {
        self.tableView = tableView
        super.init(parentObject: tableView, delegateProxy: RxTableViewDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxTableViewDelegateProxy(tableView: $0) }
    }

    // MARK: Delegate proxy methods
    /// For more information take a look at `DelegateProxyType`.
    open class func currentDelegate(for object: ParentObject) -> NSTableViewDelegate? {
        return object.delegate
    }

    /// For more information take a look at `DelegateProxyType`.
    open class func setCurrentDelegate(_ delegate: NSTableViewDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
}

extension Reactive where Base: NSTableView {

    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<NSTableView, NSTableViewDelegate> {
        return RxTableViewDelegateProxy.proxy(for: self.base)
    }
}

#endif
