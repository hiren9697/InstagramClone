//
//  AuthService.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 05/03/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthService {
    
    static func signin(email: String, password: String, completion: @escaping ResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(true))
        }
    }
    
    static func register(data: RegisterData, completion: @escaping ResultCallback) {
        
        func registerUser(imagePath: String) {
            Auth.auth().createUser(withEmail: data.email,
                                   password: data.password) { result, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let userId = result?.user.uid else {
                    completion(.failure(AuthError.emptyUserId))
                    return
                }
                Log.success("Created user successfully with id: \(userId)")
                storeUserInfo(userId: userId, imagePath: imagePath)
            }
        }
        
        func storeUserInfo(userId: String, imagePath: String) {
            let data: [String: Any] = [
                "email": data.email,
                "uid": userId,
                "fullname": data.fullName,
                "username": data.userName,
                "profileImageURL": imagePath
            ]
            DatabaseCollection.users.reference.document(userId).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    Log.success("Stored user's information successfully")
                    completion(.success(true))
                }
            }
        }
        
        if let profileImage = data.profileImage {
            ImageUploader.upload(image: profileImage) { result in
                switch result {
                case .success(let imagePath):
                    Log.success("Uploaded profile image successfuly with path: \(imagePath)")
                    registerUser(imagePath: imagePath)
                case .error(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
