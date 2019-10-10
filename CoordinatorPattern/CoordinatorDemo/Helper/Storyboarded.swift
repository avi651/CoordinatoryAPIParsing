//
//  Storyboarded.swift
//  CoordinatorDemo
//
//  Created by annpriya on 24/09/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(with storyBoardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(with storyBoardName: String) -> Self {
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
