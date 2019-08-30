//
//  BindableType.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import Foundation

protocol BindableType: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension BindableType where Self: NSViewController {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        if !isViewLoaded {
            loadView()
            viewDidLoad()
        }
        bindViewModel()
    }
}

extension BindableType where Self: NSTableCellView {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}

extension BindableType where Self: NSCollectionViewItem {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
