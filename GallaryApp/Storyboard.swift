//
//  Storyboard.swift
//  GallaryApp
//
//  Created by Sanket Patil on 06/11/23.
//

import Foundation
import UIKit

enum Storyboard {
    case tabBar
    
    var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var controller: UIViewController {
        switch self {
        case .tabBar:
            return self.main.instantiateViewController(withIdentifier: "HomeTabBarViewController")
        }
    }
    
}
