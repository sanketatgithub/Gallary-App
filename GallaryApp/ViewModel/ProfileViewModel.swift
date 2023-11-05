//
//  ProfileViewModel.swift
//  GallaryApp
//
//  Created by Sanket Patil on 06/11/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var name: String?
    @Published var emailId: String?
    @Published var profileUrl: String?
    
    func applyProfileInformation() {
        let standard = UserDefaults.standard
        
        name = "Name: \(standard.string(forKey: UserDetailsKey.FIRST_NAME.rawValue) ?? "")"
        emailId = "Email Id: \(standard.string(forKey: UserDetailsKey.EMAIL_ID.rawValue) ?? "")"
        profileUrl = standard.string(forKey: UserDetailsKey.PROFILE_PHOTO.rawValue) ?? ""
    }
}
