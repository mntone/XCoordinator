//
//  Container.swift
//  XCoordinator
//
//  Created by Stefan Kofler on 30.04.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

///
/// Container abstracts away from the difference of `UIView` and `UIViewController`
///
/// With the Container protocol, `UIView` and `UIViewController` objects can be used interchangeably,
/// e.g. when embedding containers into containers.
///
public protocol Container {

    ///
    /// The view of the Container.
    ///
    /// - Note:
    ///     It might not exist for a `UIViewController`.
    ///
    #if os(macOS)
    var view: NSView { get }
    #else
    var view: UIView! { get }
    #endif

    ///
    /// The viewController of the Container.
    ///
    /// - Note:
    ///     It might not exist for a `UIView`.
    ///
    #if os(macOS)
    var viewController: NSViewController! { get }
    #else
    var viewController: UIViewController! { get }
    #endif
}

// MARK: - Extensions

#if os(macOS)

extension NSViewController: Container {
    public var viewController: NSViewController! { return self }
}

extension NSWindow: Container {
    public var viewController: NSViewController! {
        return contentViewController
    }

    public var view: NSView { return contentView! }
}

extension NSView: Container {
    public var viewController: NSViewController! {
        return viewController(for: self)
    }

    public var view: NSView { return self }
}

extension NSView {
    private func viewController(for responder: NSResponder) -> NSViewController? {
        if let viewController = responder as? NSViewController {
            return viewController
        }

        if let nextResponser = responder.nextResponder {
            return viewController(for: nextResponser)
        }

        return nil
    }
}

#else

extension UIViewController: Container {
    public var viewController: UIViewController! { return self }
}

extension UIView: Container {
    public var viewController: UIViewController! {
        return viewController(for: self)
    }

    public var view: UIView! { return self }
}

extension UIView {
    private func viewController(for responder: UIResponder) -> UIViewController? {
        if let viewController = responder as? UIViewController {
            return viewController
        }

        if let nextResponser = responder.next {
            return viewController(for: nextResponser)
        }

        return nil
    }
}

#endif
