//
//  LoginViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 30.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

class LoginViewController: NSViewController, BindableType {
    var viewModel: LoginViewModel!

    // MARK: - Views

    @IBOutlet private var loginButton: NSButton!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
    }

    // MARK: - BindableType

    func bindViewModel() {
        loginButton.rx.tap
            .bind(to: viewModel.input.loginTrigger)
            .disposed(by: disposeBag)
    }
}
