//
//  RxTableViewDataSourceProxy.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

import AppKit
import RxCocoa
import RxSwift

extension NSTableView: HasDataSource {
    public typealias DataSource = NSTableViewDataSource
}

private let tableViewDataSourceNotSet = TableViewDataSourceNotSet()

private final class TableViewDataSourceNotSet: NSObject, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }
}

/// For more information take a look at `DelegateProxyType`.
open class RxTableViewDataSourceProxy: DelegateProxy<NSTableView, NSTableViewDataSource>, DelegateProxyType, NSTableViewDataSource {

    /// Typed parent object.
    public weak private(set) var tableView: NSTableView?

    /// - parameter tableView: Parent object for delegate proxy.
    public init(tableView: NSTableView) {
        self.tableView = tableView
        super.init(parentObject: tableView, delegateProxy: RxTableViewDataSourceProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxTableViewDataSourceProxy(tableView: $0) }
    }

    private weak var _requiredMethodsDataSource: NSTableViewDataSource? = tableViewDataSourceNotSet

    // MARK: delegate

    /// Required delegate method implementation.
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return (_requiredMethodsDataSource ?? tableViewDataSourceNotSet).numberOfRows!(in: tableView)
    }

    /// For more information take a look at `DelegateProxyType`.
    open override func setForwardToDelegate(_ forwardToDelegate: NSTableViewDataSource?, retainDelegate: Bool) {
        _requiredMethodsDataSource = forwardToDelegate  ?? tableViewDataSourceNotSet
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
    }

}

#endif
