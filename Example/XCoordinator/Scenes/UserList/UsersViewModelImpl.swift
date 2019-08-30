//
//  UsersViewModelImpl.swift
//  XCoordinator_Example
//
//  Created by Paul Kraft on 20.11.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

import Action
import RxSwift
import XCoordinator

class UsersViewModelImpl: UsersViewModel, UsersViewModelInput, UsersViewModelOutput {

    // MARK: - Inputs

    private(set) lazy var showUserTrigger: InputSubject<String> = showUserAction.inputs
	#if os(macOS)
	private(set) lazy var closeTrigger: InputSubject<Void> = closeAction.inputs
	#endif

    // MARK: - Actions

    private lazy var showUserAction = Action<String, Void> { [unowned self] username in
        self.router.rx.trigger(.user(username))
    }
	
	#if os(macOS)
	private lazy var closeAction = CocoaAction { [unowned self] in
		self.router.rx.trigger(.close)
	}
	#endif

    // MARK: - Outputs

    var usernames: Observable<[String]> = .just([
        "Stefan", "Malte", "Sebi", "Patrick", "Julian", "Quirin", "Paul", "Michael", "Eduardo", "Lizzie"
    ])

    // MARK: - Private

    private let router: AnyRouter<UserListRoute>

    // MARK: - Init

    init(router: AnyRouter<UserListRoute>) {
        self.router = router
    }
}
