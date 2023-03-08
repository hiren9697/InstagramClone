//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 05/03/23.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func upload(image: UIImage, completion: @escaping (ImageUploadResult)-> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.error(error: AuthError.emptyImageData))
            return
        }
        
        let fileName = UUID().uuidString
        let path = "/\(StorageReferencePath.profileImage.rawValue)/\(fileName)"
        let reference = Storage.storage().reference(withPath: path)
        reference.putData(imageData) { metaData, error in
            if let error = error {
                Log.error("Error in uploading image upload: \(error.localizedDescription)")
                completion(.error(error: error))
            }
            reference.downloadURL { url, error in
                if let error = error {
                    Log.error("Error in downloading image url: \(error.localizedDescription)")
                    completion(.error(error: error))
                }
                guard let url = url else {
                    Log.error("Downloaded empty url")
                    completion(.error(error: AuthError.emptyDownloadUrl))
                    return
                }
                completion(.success(path: url.absoluteString))
            }
        }
    }
}
