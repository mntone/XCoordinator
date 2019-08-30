//
//  NibIdentifiable.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import Foundation

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {
    static var nib: NSNib {
        return NSNib(nibNamed: nibIdentifier, bundle: nil)!
    }
}

extension NSView: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NSViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibIdentifiable where Self: NSViewController {

    static func instantiateFromNib() -> Self {
        return Self(nibName: nil, bundle: nil)
    }

}

extension NibIdentifiable where Self: NSView {

    static func instantiateFromNib() -> Self {
        var topLevelObjects: NSArray = []
        let topLevelObjectsPointer = AutoreleasingUnsafeMutablePointer<NSArray?>(&topLevelObjects)
        guard NSNib(nibNamed: nibIdentifier, bundle: nil)?
            .instantiate(withOwner: nil, topLevelObjects: topLevelObjectsPointer) ?? false,
            let view = topLevelObjects.firstObject as? Self else {
                fatalError("Couldn't find nib file for \(String(describing: Self.self))")
        }
        return view
    }

}
/*
 extension UITableView {

 func registerCell<T: UITableViewCell>(type: T.Type) {
 register(type.nib, forCellReuseIdentifier: String(describing: T.self))
 }

 func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
 register(type.nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
 }

 func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
 guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
 fatalError("Couldn't find nib file for \(String(describing: T.self))")
 }
 return cell
 }

 func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
 guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self),
 for: indexPath) as? T else {
 fatalError("Couldn't find nib file for \(String(describing: T.self))")
 }
 return cell
 }

 func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
 guard let headerFooterView = self
 .dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
 fatalError("Couldn't find nib file for \(String(describing: T.self))")
 }
 return headerFooterView
 }

 }

 extension UICollectionView {

 func registerCell<T: UICollectionViewCell>(type: T.Type) {
 register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
 }

 func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
 guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
 for: indexPath) as? T else {
 fatalError("Couldn't find nib file for \(String(describing: T.self))")
 }
 return cell
 }

 }
 */
