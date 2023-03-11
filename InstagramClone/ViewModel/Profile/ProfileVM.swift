//
//  ProfileVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 11/03/23.
//

import UIKit

// MARK: - VM
class ProfileVM {
    
    var webServiceOperationStatus: Observable<WebServiceOperationStatus> = Observable(.idle)
    var errorMessage: Observable<String?> = Observable(nil)
    var user: Observable<User?> = Observable(nil)
    
    var username: String {
        return user.value?.username ?? ""
    }
    var profilePictureURL: URL? {
        return user.value?.profilePictureURL
    }
    var headerVM: ProfileHeaderVM? {
        guard let user = user.value else {
            return nil
        }
        return ProfileHeaderVM(username: user.username, profilePictureURL: user.profilePictureURL)
    }
}

// MARK: - API
extension ProfileVM {
    
    internal func fetchCurrentUser() {
        webServiceOperationStatus.value = .loading
        UserService.fetchCurrentUser {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.webServiceOperationStatus.value = .idle
            switch result {
            case .success(let user):
                strongSelf.user.value = user
            case .failure(let error):
                Log.error("Couldn't get user data: \(error.localizedDescription)")
                let message: String
                if let _ = error as? ProfileErorr {
                    message = "Something went wrong"
                } else {
                    message = error.localizedDescription
                }
                strongSelf.errorMessage.value = message
            }
        }
    }
}

struct ProfileHeaderVM {
    let username: String
    let profilePictureURL: URL?
}
