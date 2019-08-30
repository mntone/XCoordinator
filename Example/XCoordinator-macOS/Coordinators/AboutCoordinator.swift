//
//  AboutCoordinator.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import XCoordinator

enum AboutRoute: Route {

}

class AboutCoordinator: RedirectionCoordinator<AboutRoute, ViewTransition> {

    // MARK: - Init

    init<T: TransitionPerformer>(superCoordinator: T) where T.TransitionType == ViewTransition {
        super.init(viewController: AboutViewController(), superTransitionPerformer: superCoordinator, prepareTransition: nil)
    }

    override func prepareTransition(for route: AboutRoute) -> ViewTransition {
        switch route {}
    }

    // MARK: - Methods

    @objc private func closeDidClick(sender: NSGestureRecognizer!) {

    }

}
