//
//  UserCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation
import XCoordinator

enum UserRoute: Route {
    case user(String)
    case alert(title: String, message: String)
    case users
    case randomColor
}

class UserCoordinator: ViewCoordinator<UserRoute> {

    // MARK: - Init

    init(user: String) {
        super.init(initialRoute: .user(user))
    }

    // MARK: - Overrides

    override func prepareTransition(for route: UserRoute) -> ViewTransition {
        switch route {
        case .randomColor:
            let viewController = NSViewController()
            viewController.view = NSView()
            viewController.view.wantsLayer = true
            viewController.view.layer!.backgroundColor = NSColor.random().cgColor
            return .embed(viewController, in: rootViewController)
        case let .user(username):
            let viewController = UserViewController.instantiateFromNib()
            let viewModel = UserViewModelImpl(router: anyRouter, username: username)
            viewController.bind(to: viewModel)
            return .embed(viewController, in: rootViewController)
        case let .alert(title, message):
            let alert = NSAlert()
            alert.messageText = title
            alert.informativeText = message
            alert.addButton(withTitle: "Ok")
            alert.beginSheetModal(for: rootViewController.view.window!, completionHandler: nil)
            return .none()
        case .users:
            return .close()
        }
    }
}

extension NSColor {
    fileprivate static func random(alpha: CGFloat? = 1) -> NSColor {
        return NSColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: alpha ?? CGFloat.random(in: 0...1)
        )
    }
}
