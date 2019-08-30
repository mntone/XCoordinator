//
//  NewsCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import XCoordinator

enum NewsRoute: Route {
    case news
    case newsDetail(News)
    case back
    case close
}

class NewsCoordinator: ViewCoordinator<NewsRoute> {

    // MARK: - Stored properties

    private var newsDetailRouteTriggerCount = -1

    // MARK: - Init

    init() {
        super.init(initialRoute: .news)
    }

    // MARK: - Overrides

    override func prepareTransition(for route: NewsRoute) -> ViewTransition {
        switch route {
        case .news:
            let viewController = NewsViewController.instantiateFromNib()
            let service = MockNewsService()
            let viewModel = NewsViewModelImpl(newsService: service, router: anyRouter)
            viewController.bind(to: viewModel)
            return .present(viewController)
        case .newsDetail(let news):
            let viewController = NewsDetailViewController.instantiateFromNib()
            let viewModel = NewsDetailViewModelImpl(news: news, router: anyRouter)
            viewController.bind(to: viewModel)
            newsDetailRouteTriggerCount += 1
            return .present(viewController, animation: [.fade, .slide][newsDetailRouteTriggerCount % 2])
        case .back:
            return .dismiss(animation: [.fade, .slide][newsDetailRouteTriggerCount % 2])
        case .close:
            return .dismissToRoot()
        }
    }
}
