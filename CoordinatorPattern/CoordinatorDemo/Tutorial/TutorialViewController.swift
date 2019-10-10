//
//  TutorialViewController.swift
//  CoordinatorDemo
//
//  Created by annpriya on 24/09/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import UIKit

/// Important : Any tap in VC can be handled using closure or delegate function.

public protocol TutorialViewControllerDelegate: class {
    func didNextTapped()
}

class TutorialViewController: UIViewController, Storyboarded {
    
    /// Using Closure
    internal var doNavigation: () -> Void = { }
    
    /// Using delegate
    internal weak var delegate: TutorialViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.callAPI()
        FLocationManager.shared.start{ (info) in
            print(info.longitude ?? 0.0)
            print(info.latitude ?? 0.0)
            print(info.address ?? "")
            print(info.city ?? "")
            print(info.zip ?? "")
        }
    }
    
    @IBAction private func nextTapped(_ sender: UIButton) {
        // using closure
        // doNavigation()
        
        // using delegate
        delegate?.didNextTapped()
    }
    
    private func callAPI() {
    
        ResultsData().fetch(queryValue: "restaurant", location: "25.5941,85.1376", radius: 10000) { (resultData, httpStatusCode) in
            debugPrint(">>>>>> :\(resultData.results[0].formattedAddress)")
            debugPrint(">>>>>> :\(httpStatusCode)")
        }
    
    }
    
}

extension TutorialViewController{
    
    
}
