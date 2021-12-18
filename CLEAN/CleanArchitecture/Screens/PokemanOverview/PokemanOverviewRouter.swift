//
//  PokemanOverviewRouter.swift
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

@objc protocol PokemanOverviewRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PokemanOverviewDataPassing {
    var dataStore: PokemanOverviewDataStore? { get }
}

class PokemanOverviewRouter: NSObject, PokemanOverviewRoutingLogic, PokemanOverviewDataPassing {
    weak var viewController: PokemanOverviewViewController?
    var dataStore: PokemanOverviewDataStore?

// MARK: Routing (navigating to other screens)

//func routeToSomewhere(segue: UIStoryboardSegue?) {
//    if let segue = segue {
//        let destinationVC = segue.destination as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//    } else {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }
//}

// MARK: Navigation to other screen

//func navigateToSomewhere(source: PokemanOverviewViewController, destination: SomewhereViewController) {
//    source.show(destination, sender: nil)
//}

// MARK: Passing data to other screen

//    func passDataToSomewhere(source: PokemanOverviewDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
