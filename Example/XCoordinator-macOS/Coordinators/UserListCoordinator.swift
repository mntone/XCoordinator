//
//  UserListCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import XCoordinator

enum UserListRoute: Route {
    case home
    case users
    case user(String)
    case close
    case logout
    case about
}

class UserListCoordinator: ViewCoordinator<UserListRoute> {

    // MARK: - Init

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Overrides

    override func prepareTransition(for route: UserListRoute) -> ViewTransition {
        switch route {
        case .home:
            let viewController = HomeViewController.instantiateFromNib()
            let viewModel = HomeViewModelImpl(router: anyRouter)
            viewController.bind(to: viewModel)
            return .present(viewController)
        case .users:
            let viewController = UsersViewController.instantiateFromNib()
            let viewModel = UsersViewModelImpl(router: anyRouter)
            viewController.bind(to: viewModel)
            return .present(viewController)
        case .user(let username):
            let coordinator = UserCoordinator(user: username)
            return .presentAsSheet(coordinator)
        case .close:
            return .dismiss()
        case .logout:
            return .dismissToRoot()
        case .about:
            let coordinator = AboutCoordinator(superCoordinator: self)
            return .presentAsSheet(coordinator)
        }
    }
}
