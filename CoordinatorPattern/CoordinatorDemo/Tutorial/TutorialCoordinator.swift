//
//  TutorialCoordinator.swift
//  CoordinatorDemo
//
//  Created by annpriya on 24/09/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import UIKit

public final class TutorialCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private var dashboardCoordinator: DashboardCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let tutorialVC = TutorialViewController.instantiate(with: "Main")
        self.navigationController.navigationBar.isHidden = true
        /// Either set delegate or assign closure to get the call back.
        tutorialVC.delegate = self
      //  tutorialVC.doNavigation = doNavigation
        navigationController.pushViewController(tutorialVC, animated: true)
    }
    
    private func doNavigation() {
        // Do Navigation
    }
    
}

extension TutorialCoordinator: TutorialViewControllerDelegate {
    public func didNextTapped() {
        // Do Navigation
       let dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
       self.dashboardCoordinator = dashboardCoordinator
       dashboardCoordinator.start()
    }
    
    
}
