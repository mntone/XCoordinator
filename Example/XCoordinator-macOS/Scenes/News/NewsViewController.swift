//
//  NewsViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 30.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit
import RxCocoa
import RxSwift

private let CellIdentifierString: String = "News"
private let CellIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: CellIdentifierString)

class NewsViewController: NSViewController, BindableType {
    var viewModel: NewsViewModel!

    // MARK: - Views

    @IBOutlet private var tableView: NSTableView!

    // MARK: - Stored properties

    private let disposeBag = DisposeBag()

    private var dataSource: RxTableViewReactiveArrayDataSource<News>?

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableViewCell()
    }

    // MARK: - BindableType

    func bindViewModel() {
        let dataSource = RxTableViewReactiveArrayDataSource<News> { [unowned self] _, _, element in
            let cell: NSView? = self.tableView.makeView(withIdentifier: CellIdentifier, owner: self)
            if cell == nil {
                let cell2 = NSText()
                cell2.drawsBackground = false
                cell2.identifier = CellIdentifier
                cell2.isEditable = false
                cell2.isSelectable = false
                cell2.string = element.title
                return cell2
            }
            (cell as? NSText)?.string = element.title
            return cell
        }
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        viewModel.output.news
            .subscribe(onNext: { [weak self] news in
                guard let tableView = self?.tableView else { return }
                dataSource.tableView(tableView, observedElements: news)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(News.self)
            .bind(to: viewModel.input.selectedNews)
            .disposed(by: disposeBag)

        viewModel.output.title
            .subscribe(onNext: { [weak self] title in self?.title = title })
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureTableViewCell() {
        tableView.tableColumns.forEach(tableView.removeTableColumn)
        tableView.addTableColumn(NSTableColumn(identifier: CellIdentifier))
    }
}
