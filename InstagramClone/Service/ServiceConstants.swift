//
//  ServiceConstants.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 05/03/23.
//

import FirebaseFirestore

enum StorageReferencePath: String {
    case profileImage = "profile_image"
    case postImage = "post_image"
}

enum DatabaseCollection: String {
    case users = "users"
    
    var reference: CollectionReference {
        return Firestore.firestore().collection(self.rawValue)
    }
}
