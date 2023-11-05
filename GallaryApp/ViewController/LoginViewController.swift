//
//  LoginViewController.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logInView: UIView!
    @IBOutlet weak var userLoginLabel: UILabel!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSignInView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setupNavigation()
    }
    
    func setupNavigation() {
        if loginViewModel.isUserLoggedIn() {
            self.navigateOnTabBarController()
        } else {
            self.logInView.isHidden = false
        }
    }
    
    func setupSignInView() {
        self.logInView.layer.cornerRadius = 12.0
        self.logInView.layer.masksToBounds = true
    }
    
    @IBAction func onClickSignInButton(sender: UIButton) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print(error ?? "")
                return
            }
            guard let profileData = signInResult?.user.profile else { return }
            self.loginViewModel.markUserSignIn()
            self.loginViewModel.updateUserInformation(profileData: profileData)
            self.setupNavigation()
        }
    }
}

extension LoginViewController {
    func navigateOnTabBarController() {
        guard let tabBarViewController = Storyboard.tabBar.controller as? HomeTabBarViewController else { return }
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
}
