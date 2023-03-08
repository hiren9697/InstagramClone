//
//  AuthenticationModel.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 05/03/23.
//

import UIKit

// MARK: - Register Data
struct RegisterData {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage?
}

// MARK: - Custom Error
enum AuthError: Error {
    case emptyImageData
    case emptyUserId
    case emptyDownloadUrl
}

extension AuthError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptyImageData: return "Something went wrong, Please try again"
        case .emptyUserId: return "Something went wrong"
        case .emptyDownloadUrl: return "Somwthing went wrong"
        }
    }
}

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyImageData: return "Found empty image data while uploading to storage"
        case .emptyUserId: return "Found empty user id in register user"
        case .emptyDownloadUrl: return "Found empty url in image upload"
        }
    }
}
