//
//  UserViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

class UserViewController: NSViewController, BindableType {
    var viewModel: UserViewModel!

    // MARK: - Views

    @IBOutlet private var username: NSTextField!
    @IBOutlet private var showAlertButton: NSButton!
    @IBOutlet private var closeButton: NSButton!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    // MARK: - BindableType

    func bindViewModel() {
        viewModel.output.username
            .bind(to: username.rx.text)
            .disposed(by: disposeBag)

        showAlertButton.rx.tap
            .bind(to: viewModel.input.alertTrigger)
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .bind(to: viewModel.input.closeTrigger)
            .disposed(by: disposeBag)
    }
}
