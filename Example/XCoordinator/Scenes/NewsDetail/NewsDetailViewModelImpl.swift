//  
//  NewsDetailViewModelImpl.swift
//  XCoordinator_Example
//
//  Created by Paul Kraft on 28.07.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

import Action
import Foundation
import RxSwift
import XCoordinator

class NewsDetailViewModelImpl: NewsDetailViewModel, NewsDetailViewModelInput, NewsDetailViewModelOutput {
	
	// MARK: - Inputs
	
	#if os(macOS)
	private(set) lazy var backTrigger: InputSubject<Void> = backAction.inputs
	#endif
	
	// MARK: - Actions
	
	#if os(macOS)
	private lazy var backAction = CocoaAction { [unowned self] in
		self.router.rx.trigger(.back)
	}
	#endif
	
    // MARK: - Outputs

    let news: Observable<News>

	// MARK: - Private
	
	private let router: AnyRouter<NewsRoute>

    // MARK: - Init

    init(news: News, router: AnyRouter<NewsRoute>) {
        self.news = .just(news)
		self.router = router
    }

}
