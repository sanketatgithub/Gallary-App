//
//  ProfileViewController.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation
import UIKit
import GoogleSignIn
import Combine

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let profileViewModel = ProfileViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.setupUI()
        self.profileViewModel.applyProfileInformation()
    }
    
    private func setupUI() {
        self.profileViewModel.$name.assign(to: \.text, on: self.firstNameLabel).store(in: &cancellables)
        self.profileViewModel.$emailId.assign(to: \.text, on: self.emailLabel).store(in: &cancellables)
        self.profileImageView.layer.cornerRadius = 70
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        self.profileViewModel.$profileUrl.receive(on: RunLoop.main).sink { value in
            if let value = value, let profileUrl = URL(string: value) {
                self.profileImageView.loadImage(url: profileUrl)
            }
        }.store(in: &cancellables)
    }
    
    private func displaySignOutConfirmationAlertView() {
        
        let alert = UIAlertController(title: "Are you sure want to sign out?", message: "" , preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        alert.editButtonItem.tintColor = UIColor.black
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.dismiss(animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.userLogout()
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func revokeAccess() {
        GIDSignIn.sharedInstance.disconnect()
        // This revokes the access token from Google.
    }
    
    private func userLogout() {
        GIDSignIn.sharedInstance.signOut()
        revokeAccess()
        UserDefaults.standard.set(false, forKey: UserDetailsKey.USER_LOGGED_IN.rawValue)
        UserDefaults.standard.synchronize()
        if let controller = self.tabBarController as? HomeTabBarViewController {
            controller.performBackNavigation()
        }
    }

    
    @IBAction func onClickLogoutButton(sender: UIButton) {
        self.displaySignOutConfirmationAlertView()
    }
}
