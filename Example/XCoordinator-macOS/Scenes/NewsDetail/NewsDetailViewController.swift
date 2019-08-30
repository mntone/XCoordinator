//
//  NewsDetailViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 30.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

class NewsDetailViewController: NSViewController, BindableType {
    var viewModel: NewsDetailViewModel!

    // MARK: - Views

    @IBOutlet private weak var backButton: NSButton!
    @IBOutlet private weak var imageView: NSImageView!
    @IBOutlet private weak var titleLabel: NSTextField!
    @IBOutlet private var contentTextView: NSTextView!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    // MARK: - BindableType

    func bindViewModel() {
        viewModel.output.news
            .map { $0.title + "\n" + $0.subtitle }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.news
            .map { $0.content }
            .bind(to: contentTextView.rx.string)
            .disposed(by: disposeBag)

        viewModel.output.news
            .map { $0.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        backButton.rx.tap
            .bind(to: viewModel.input.backTrigger)
            .disposed(by: disposeBag)
    }
}
