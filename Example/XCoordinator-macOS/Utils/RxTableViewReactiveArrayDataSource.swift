//
//  RxTableViewReactiveArrayDataSource.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

import AppKit
import RxCocoa
import RxSwift

// objc monkey business
class _RxTableViewReactiveArrayDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }

    fileprivate func _tableView(_ tableView: NSTableView, viewFor row: Int) -> NSView? {
        fatalError("Abstract method")
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return _tableView(tableView, viewFor: row)
    }
}

class RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence: Swift.Sequence>: RxTableViewReactiveArrayDataSource<Sequence.Element>, RxTableViewDataSourceType {
    typealias Element = Sequence

    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
    }

    func tableView(_ tableView: NSTableView, observedEvent: Event<Sequence>) {
        Binder(self) { tableViewDataSource, sectionModels in
            let sections = Array(sectionModels)
            tableViewDataSource.tableView(tableView, observedElements: sections)
            }.on(observedEvent)
    }
}

// Please take a look at `DelegateProxyType.swift`
class RxTableViewReactiveArrayDataSource<Element>: _RxTableViewReactiveArrayDataSource, SectionedViewDataSourceType {
    typealias CellFactory = (NSTableView, Int, Element) -> NSView?

    var itemModels: [Element]?

    func modelAtIndex(_ index: Int) -> Element? {
        return itemModels?[index]
    }

    func model(at indexPath: IndexPath) throws -> Any {
        precondition(indexPath.section == 0)
        guard let items = itemModels, indexPath.item >= 0, indexPath.item < items.count else {
            throw RxCocoaError.itemsNotYetBound(object: self)
        }
        return items[indexPath.item]
    }

    let cellFactory: CellFactory

    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }

    override func numberOfRows(in tableView: NSTableView) -> Int {
        return itemModels?.count ?? 0
    }

    override func _tableView(_ tableView: NSTableView, viewFor row: Int) -> NSView? {
        return cellFactory(tableView, row, itemModels![row])
    }

    // reactive

    func tableView(_ tableView: NSTableView, observedElements: [Element]) {
        self.itemModels = observedElements

        tableView.reloadData()
    }
}

#endif
