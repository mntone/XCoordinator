//
//  NSTableView+Rx.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

import AppKit
import RxCocoa
import RxSwift

// MARK: casts or fatal error
func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }

    return returnValue
}

func castOrFatalError<T>(_ value: AnyObject!, message: String) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        fatalError(message)
    }

    return result
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        fatalError("Failure converting from \(String(describing: value)) to \(T.self)")
    }

    return result
}

extension Reactive where Base: NSTableView {
    /**
     Reactive wrapper for `dataSource`.

     For more information take a look at `DelegateProxyType` protocol documentation.
     */
    public var dataSource: DelegateProxy<NSTableView, NSTableViewDataSource> {
        return RxTableViewDataSourceProxy.proxy(for: base)
    }

    /**
     Installs data source as forwarding delegate on `rx.dataSource`.
     Data source won't be retained.

     It enables using normal delegate mechanism with reactive delegate mechanism.

     - parameter dataSource: Data source object.
     - returns: Disposable object that can be used to unbind the data source.
     */
    public func setDataSource(_ dataSource: NSTableViewDataSource)
        -> Disposable {
            return RxTableViewDataSourceProxy.installForwardDelegate(dataSource, retainDelegate: false, onProxyForObject: self.base)
    }

    // events

    /**
     Reactive wrapper for `delegate` message `tableView:didSelectRowAtIndexPath:`.
     */
    public var itemSelected: ControlEvent<()> {
        let source = self.delegate.methodInvoked(#selector(NSTableViewDelegate.tableViewSelectionDidChange(_:)))
            .map {  _ in
                return ()
        }

        return ControlEvent(events: source)
    }

    /**
     Reactive wrapper for `delegate` message `tableView:didSelectRowAtIndexPath:`.

     It can be only used when one of the `rx.itemsWith*` methods is used to bind observable sequence,
     or any other data source conforming to `SectionedViewDataSourceType` protocol.

     ```
     tableView.rx.modelSelected(MyModel.self)
     .map { ...
     ```
     */
    public func modelSelected<T>(_ modelType: T.Type) -> ControlEvent<T> {
        let source: Observable<T> = self.itemSelected.flatMap { [weak view = self.base as NSTableView] () -> Observable<T> in
            guard let view = view else {
                return Observable.empty()
            }

            guard let model: T = try? view.rx.model(at: view.selectedRow) else {
                return Observable.empty()
            }
            return Observable.just(model)
        }

        return ControlEvent(events: source)
    }

    /**
     Synchronous helper method for retrieving a model at indexPath through a reactive data source.
     */
    public func model<T>(at index: Int) throws -> T {
        let dataSource: SectionedViewDataSourceType = castOrFatalError(self.dataSource.forwardToDelegate(), message: "This method only works in case one of the `rx.items*` methods was used.")

        let element = try dataSource.model(at: IndexPath(item: index, section: 0))

        return castOrFatalError(element)
    }
}

#endif
