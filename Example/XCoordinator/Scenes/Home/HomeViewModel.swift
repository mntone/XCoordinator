//  
//  HomeViewModel.swift
//  XCoordinator_Example
//
//  Created by Joan Disho on 04.05.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

import Action
import RxSwift
import XCoordinator

protocol HomeViewModelInput {
    var logoutTrigger: InputSubject<Void> { get }
    var usersTrigger: InputSubject<Void> { get }
    var aboutTrigger: InputSubject<Void> { get }
}

protocol HomeViewModelOutput {}

protocol HomeViewModel {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }

    #if os(iOS) || os(tvOS)
    func registerPeek(for sourceView: Container)
	#endif
}

extension HomeViewModel where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}
