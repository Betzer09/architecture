//
//  PokemanOverviewPresenter.swift
//  CleanArchitecture
//
//  Created by Austin Betzer on 12/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PokemanOverviewPresentationLogic {
    func presentSomething(response: PokemanOverview.Something.Response)
}

class PokemanOverviewPresenter: PokemanOverviewPresentationLogic {
    weak var viewController: PokemanOverviewDisplayLogic?

    // MARK: Parse and calc respnse from PokemanOverviewInteractor and send simple view model to PokemanOverviewViewController to be displayed

    func presentSomething(response: PokemanOverview.Something.Response) {
        let viewModel = PokemanOverview.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: PokemanOverview.SomethingElse.Response) {
//        let viewModel = PokemanOverview.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
