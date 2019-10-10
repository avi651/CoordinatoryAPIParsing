//
//  DashboardCoordinator.swift
//  CoordinatorDemo
//
//  Created by annpriya on 25/09/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import UIKit

public final class DashboardCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
       let dashBoardVC = DashboardViewController.instantiate(with: "Dashboard")
        self.navigationController.navigationBar.isHidden = false
       dashBoardVC.doNavigation = doNavigation
       navigationController.pushViewController(dashBoardVC, animated: true)
    }
    
    private func doNavigation(tappedText: String) {
        let dashboardDetailVC = DashboardDetailViewController.instantiate(with: "Dashboard")
        dashboardDetailVC.str = tappedText
        navigationController.pushViewController(dashboardDetailVC, animated: true)
    }


}
