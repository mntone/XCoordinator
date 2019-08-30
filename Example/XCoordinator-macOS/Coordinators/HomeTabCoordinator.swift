//
//  HomeTabCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case news
    case userList
}

class HomeTabCoordinator: TabViewCoordinator<HomeRoute> {

    // MARK: - Stored properties

    private let newsRouter: AnyRouter<NewsRoute>
    private let userListRouter: AnyRouter<UserListRoute>

    // MARK: - Init

    init(newsRouter: AnyRouter<NewsRoute> = NewsCoordinator().anyRouter,
         userListRouter: AnyRouter<UserListRoute> = UserListCoordinator().anyRouter) {
        self.newsRouter = newsRouter
        self.userListRouter = userListRouter

        super.init(tabs: [newsRouter, userListRouter], select: userListRouter)
    }

    // MARK: - Overrides

    override func prepareTransition(for route: HomeRoute) -> TabViewTransition {
        switch route {
        case .news:
            return .select(newsRouter)
        case .userList:
            return .select(userListRouter)
        }
    }
}
