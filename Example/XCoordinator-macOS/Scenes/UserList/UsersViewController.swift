//
//  UsersViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

private let CellIdentifierString: String = "User"
private let CellIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: CellIdentifierString)

extension NSText {
    open override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
}

class UsersViewController: NSViewController, BindableType {
    var viewModel: UsersViewModel!

    // MARK: - Views

    @IBOutlet private weak var closeButton: NSButton!
    @IBOutlet private weak var tableView: NSTableView!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    private var dataSource: RxTableViewReactiveArrayDataSource<String>?

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableViewCell()
        configureTitleBar()
    }

    // MARK: - BindableType

    func bindViewModel() {
        let dataSource = RxTableViewReactiveArrayDataSource<String> { [unowned self] _, _, element in
            let cell: NSView? = self.tableView.makeView(withIdentifier: CellIdentifier, owner: self)
            if cell == nil {
                let cell2 = NSText()
                cell2.drawsBackground = false
                cell2.identifier = CellIdentifier
                cell2.isEditable = false
                cell2.isSelectable = false
                cell2.string = element
                return cell2
            }
            (cell as? NSText)?.string = element
            return cell
        }
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        viewModel.output.usernames
            .subscribe(onNext: { [weak self] usernames in
                guard let tableView = self?.tableView else { return }
                dataSource.tableView(tableView, observedElements: usernames)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.input.showUserTrigger)
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .bind(to: viewModel.input.closeTrigger)
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureTableViewCell() {
        tableView.tableColumns.forEach(tableView.removeTableColumn)
        tableView.addTableColumn(NSTableColumn(identifier: CellIdentifier))
    }

    private func configureTitleBar() {
        title = "Users"
    }
}
