//
//  AppCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case login
    case home
    case newsDetail(News)
}

class AppCoordinator: ViewCoordinator<AppRoute> {

    // MARK: - Stored properties

    // We need to keep a reference to the HomeCoordinator
    // as it is not held by any viewModel or viewController
    private var home: Presentable?
    private var homeRouteTriggerCount = 0

    // MARK: - Init

    init() {
        super.init(initialRoute: .login)
    }

    // MARK: - Overrides

    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {
        case .login:
            let viewController = LoginViewController.instantiateFromNib()
            let viewModel = LoginViewModelImpl(router: anyRouter)
            viewController.bind(to: viewModel)
            return .present(viewController)
        case .home:
            let presentables: [() -> Presentable] = [ { HomeTabCoordinator() }, { HomeSplitCoordinator() }, { HomePageCoordinator() }
            ]
            let presentable = presentables[homeRouteTriggerCount % presentables.count]()
            homeRouteTriggerCount = (homeRouteTriggerCount + 1) % presentables.count
            self.home = presentable
            return .present(presentable)
        case .newsDetail(let news):
            return deepLink(AppRoute.home, HomeRoute.news, NewsRoute.newsDetail(news))
        }
    }

    // MARK: - Methods

    func notificationReceived() {
        guard let news = MockNewsService().mostRecentNews().articles.randomElement() else {
            return
        }
        self.trigger(.newsDetail(news))
    }
}
