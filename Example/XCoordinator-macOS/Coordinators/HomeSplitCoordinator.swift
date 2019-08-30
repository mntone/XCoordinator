//
//  HomeSplitCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import XCoordinator

class HomeSplitCoordinator: SplitCoordinator<HomeRoute> {

    // MARK: - Stored properties

    private let newsRouter: AnyRouter<NewsRoute>
    private let userListRouter: AnyRouter<UserListRoute>

    // MARK: - Init

    init(newsRouter: AnyRouter<NewsRoute> = NewsCoordinator().anyRouter,
         userListRouter: AnyRouter<UserListRoute> = UserListCoordinator().anyRouter) {
        self.newsRouter = newsRouter
        self.userListRouter = userListRouter

        super.init(sections: [userListRouter, newsRouter])
    }

    // MARK: - Overrides

    override func prepareTransition(for route: HomeRoute) -> SplitTransition {
        switch route {
        case .news:
            return .none()
        case .userList:
            return .none()
        }
    }
}
