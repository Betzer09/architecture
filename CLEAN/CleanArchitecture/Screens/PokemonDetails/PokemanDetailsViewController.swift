//
//  PokemanDetailsViewController.swift
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

protocol PokemanDetailsDisplayLogic: AnyObject {
    func displaySomething(viewModel: PokemanDetails.Something.ViewModel)
//    func displaySomethingElse(viewModel: PokemanDetails.SomethingElse.ViewModel)
}

class PokemanDetailsViewController: UIViewController, PokemanDetailsDisplayLogic {
    var interactor: PokemanDetailsBusinessLogic?
    var router: (NSObjectProtocol & PokemanDetailsRoutingLogic & PokemanDetailsDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = PokemanDetailsInteractor()
        let presenter = PokemanDetailsPresenter()
        let router = PokemanDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
//        doSomethingElse()
    }
    
    //MARK: - receive events from UI
    
    //@IBOutlet weak var nameTextField: UITextField!
//
//    @IBAction func someButtonTapped(_ sender: Any) {
//
//    }
//
//    @IBAction func otherButtonTapped(_ sender: Any) {
//
//    }
    
    // MARK: - request data from PokemanDetailsInteractor

    func doSomething() {
        let request = PokemanDetails.Something.Request()
        interactor?.doSomething(request: request)
    }
//
//    func doSomethingElse() {
//        let request = PokemanDetails.SomethingElse.Request()
//        interactor?.doSomethingElse(request: request)
//    }

    // MARK: - display view model from PokemanDetailsPresenter

    func displaySomething(viewModel: PokemanDetails.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
//
//    func displaySomethingElse(viewModel: PokemanDetails.SomethingElse.ViewModel) {
//        // do sometingElse with viewModel
//    }
}