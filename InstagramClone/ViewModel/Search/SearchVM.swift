//
//  SearchVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 11/03/23.
//

import UIKit

struct SearchUserVM {
    let profilePicture: URL?
    let username: String
    let fullname: String
    
    init(user: User) {
        self.profilePicture = user.profilePictureURL
        self.username = user.username
        self.fullname = user.fullname
    }
}

class SearchVM {
    
    var webServiceOperationStatus: Observable<WebServiceOperationStatus> = Observable(.idle)
    var errorMessage: Observable<String?> = Observable(nil)
    var users: Observable<[User]> = Observable([])
    
    func getUserVM(for indexPath: IndexPath)-> SearchUserVM {
        return SearchUserVM(user: users.value[indexPath.row])
    }
    
    func fetchUsers() {
        UserService.fetchUsers {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let users):
                strongSelf.users.value = users
            case .failure(let error):
                Log.error("Couldn't fetch users in search: \(error.localizedDescription)")
                strongSelf.errorMessage.value = error.localizedDescription
            }
        }
    }
}
