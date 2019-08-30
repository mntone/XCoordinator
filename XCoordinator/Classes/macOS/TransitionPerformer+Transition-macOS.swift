//
//  TransitionPerformer+Transition.swift
//  XCoordinator
//
//  Created by mntone on 28.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

#if os(macOS)

extension NSViewController {

    private var rootViewController: NSViewController? {
        return parent?.rootViewController ?? parent
    }

    private var topPresentedViewController: NSViewController? {
        return presentedViewControllers?.first?.topPresentedViewController ?? presentedViewControllers?.first
    }

    func presentAsPopover(_ viewController: NSViewController,
                          relativeTo positioningRect: NSRect,
                          of positioningView: NSView,
                          preferredEdge: NSRectEdge,
                          behavior: NSPopover.Behavior,
                          completion: PresentationHandler?) {
        present(viewController,
                asPopoverRelativeTo: positioningRect,
                of: positioningView,
                preferredEdge: preferredEdge,
                behavior: behavior)

        completion?()
    }

    func presentAsModalWindow(_ viewController: NSViewController,
                              completion: PresentationHandler?) {
        presentAsModalWindow(viewController)

        completion?()
    }

    func presentAsSheet(_ viewController: NSViewController,
                        completion: PresentationHandler?) {
        presentAsSheet(viewController)

        completion?()
    }

    func transition(onRoot: Bool,
                    _ viewController: NSViewController,
                    with options: NSViewController.TransitionOptions,
                    completion: PresentationHandler?) {
        let presentingViewController = onRoot
            ? children.first!
            : children.last!
        viewController.view.autoresizingMask = [.width, .height]
        viewController.view.frame = presentingViewController.view.frame

        addChild(viewController)
        transition(from: presentingViewController,
                   to: viewController,
                   options: options,
                   completionHandler: completion)
    }

    func present(onTop: Bool,
                 _ viewController: NSViewController,
                 with options: XCoordinator.TransitionOptions,
                 animation: Animation,
                 completion: PresentationHandler?) {
        animation.options = options
        animation.completion = completion

        let presentingViewController = onTop
            ? (topPresentedViewController ?? self)
            : self
        presentingViewController.present(viewController, animator: animation)
    }

    func dismiss(toRoot: Bool,
                 with options: XCoordinator.TransitionOptions,
                 animation: Animation,
                 completion: PresentationHandler?) {
        guard let rootViewController = toRoot ? rootViewController : self,
            let dismissalViewController = rootViewController.children.last else { return }

        animation.options = options
        animation.completion = {
            dismissalViewController.removeFromParent()
            completion?()
        }
        rootViewController.dismiss(dismissalViewController)
    }

    func close() {
        let closingViewController = rootViewController
        dismiss(closingViewController)
    }

    func embedToRoot(_ viewController: NSViewController,
                     completion: PresentationHandler?) {
        view.window!.contentViewController = viewController

        completion?()
    }

    func embed(_ viewController: NSViewController,
               in container: Container,
               completion: PresentationHandler?) {
        container.viewController.addChild(viewController)

        viewController.view.autoresizingMask = [.width, .height]
        viewController.view.frame = container.view.frame
        container.view.addSubview(viewController.view)

        completion?()
    }
}

#endif
