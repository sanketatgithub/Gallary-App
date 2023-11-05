//
//  LoginViewModel.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation
import GoogleSignIn.GIDGoogleUser

enum UserDetailsKey: String {
    case USER_LOGGED_IN = "userLoggedIn"
    case FIRST_NAME = "firstName"
    case EMAIL_ID = "emailId"
    case PROFILE_PHOTO = "userProfile"
}

class LoginViewModel {
    
    func isUserLoggedIn() -> Bool {
        let standard = UserDefaults.standard
        return standard.value(forKey: UserDetailsKey.USER_LOGGED_IN.rawValue) != nil && standard.bool(forKey: UserDetailsKey.USER_LOGGED_IN.rawValue)
    }
    
    func markUserSignIn() {
        UserDefaults.standard.set(true, forKey: UserDetailsKey.USER_LOGGED_IN.rawValue)
        UserDefaults.standard.synchronize()
    }

    func updateUserInformation(profileData: GIDProfileData) {
        // values from google Signin
        // var userId = user.userID
        let name = profileData.name
        let email = profileData.email
        
        UserDefaults.standard.set(name, forKey: UserDetailsKey.FIRST_NAME.rawValue)
        UserDefaults.standard.set(email, forKey: UserDetailsKey.EMAIL_ID.rawValue)
        if profileData.hasImage {
            let imageUrl = profileData.imageURL(withDimension: 120)
            print(" image url: ", imageUrl?.absoluteString ?? "")
            UserDefaults.standard.set(imageUrl?.absoluteString ?? "", forKey: UserDetailsKey.PROFILE_PHOTO.rawValue)
        }
        
        UserDefaults.standard.synchronize()
    }
}
