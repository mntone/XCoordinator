//
//  NSView+Store.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

private var associatedObjectHandle: UInt8 = 0

extension NSView {

    var strongReferences: [Any] {
        get {
            return objc_getAssociatedObject(self, &associatedObjectHandle) as? [Any] ?? []
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

#endif
