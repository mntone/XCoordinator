//
//  HomeViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

class HomeViewController: NSViewController, BindableType {
    var viewModel: HomeViewModel!

    // MARK: - Views

    @IBOutlet private var logoutButton: NSButton!
    @IBOutlet private var usersButton: NSButton!
    @IBOutlet private var aboutButton: NSButton!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    // MARK: - Overrides

    override func loadView() {
        super.loadView()

        title = "Home"
    }

    // MARK: - BindableType

    func bindViewModel() {
        logoutButton.rx.tap
            .bind(to: viewModel.input.logoutTrigger)
            .disposed(by: disposeBag)

        usersButton.rx.tap
            .bind(to: viewModel.input.usersTrigger)
            .disposed(by: disposeBag)

        aboutButton.rx.tap
            .bind(to: viewModel.input.aboutTrigger)
            .disposed(by: disposeBag)
    }
}
