//
//  UserService.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 11/03/23.
//

import FirebaseAuth
import FirebaseFirestore

class User {
    let id: String
    let email: String
    let fullname: String
    let username: String
    let profilePictureURLString: String
    
    var profilePictureURL: URL? {
        return URL(string: profilePictureURLString)
    }
    
    init(dict: NSDictionary) {
        id = dict.stringValue(key: "uid")
        email = dict.stringValue(key: "email")
        fullname = dict.stringValue(key: "fullname")
        username = dict.stringValue(key: "username")
        profilePictureURLString = dict.stringValue(key: "profileImageURL")
    }
}

class UserService {
    
    static func fetchCurrentUser(completion: @escaping ((Result<User, Error>)-> ())) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(GeneralError.emptyCurrentUser))
            return
        }
        DatabaseCollection.users.reference.document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dict = snapshot?.data() as? NSDictionary else {
                completion(.failure(ProfileErorr.emptyProfileData))
                return
            }
            let user = User(dict: dict)
            completion(.success(user))
        }
    }
    
    static func fetchUsers(completion: @escaping ((Result<[User], Error>)-> ())) {
        DatabaseCollection.users.reference.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            }
            let users = snapshot?.documents.map({ User(dict: $0.data() as NSDictionary) })
            completion(.success(users ?? []))
        }
    }
}
