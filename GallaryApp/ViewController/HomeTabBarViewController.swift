//
//  HomeTabBarViewController.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation
import UIKit

class HomeTabBarViewController: UITabBarController, UITabBarControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBar.items?[0].title = "Gallary"
        self.tabBar.items?[1].title = "Profile"
    }
    
    func performBackNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
}
