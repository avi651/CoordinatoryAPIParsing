//
//  DashboardViewController.swift
//  CoordinatorDemo
//
//  Created by annpriya on 25/09/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, Storyboarded {
    
    internal var doNavigation: ((_ tappedText: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Navigation First Page")
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnTapped(_ sender: UIButton) {
        doNavigation?("Coordinator Pattern Demo")
    }

}
