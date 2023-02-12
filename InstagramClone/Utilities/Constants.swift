//
//  Constants.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 28/05/22.
//

import UIKit
//import FirebaseDatabase
import FirebaseStorage

struct App {
    static let application    = UIApplication.shared
    static let appDelegator   = UIApplication.shared.delegate! as! AppDelegate
    static let defaultCenter  = NotificationCenter.default
    static let userDefault    = UserDefaults.standard
    //static var user: User?
}

struct Geometry {
    static let screenFrame     : CGRect     = UIScreen.main.bounds
    static let screenSize      : CGSize     = UIScreen.main.bounds.size
    static let screenWidth     : CGFloat    = screenSize.width
    static let screenHeight    : CGFloat    = screenSize.height
    static let windowScene     : UIWindowScene?   = App.application.connectedScenes.first as? UIWindowScene
    static let window          : UIWindow?  = windowScene?.windows.last
    static let topSafearea     : CGFloat   = window?.safeAreaInsets.top ?? 0
    static let bottomSafearea  : CGFloat = window?.safeAreaInsets.bottom ?? 0
}

//struct RemoteDatabase {
//    static let reference = Database.database(url: "https://twitterclone-62338-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
//    static let usersReference = reference.child("users")
//    static let tweetReference = reference.child("tweets")
//    static let userTweetsReference = reference.child("user_tweets")
//}
//
//struct RemoteStorage {
//    static let reference = Storage.storage()
//    static let userProfileImageReference = reference.reference(withPath: "profile_image")
//}

struct AppNotification {
    static let userUpdated: Notification.Name = Notification.Name("userUpdated")
}

enum AppErrorDomains: String {
    case TweetService
    case AppUser
    case InappropriateAPIResponse
}

struct AppErrors {
    static let userObjectNotFound = NSError(domain: AppErrorDomains.AppUser.rawValue,
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Couldn't found global user object"])
    static let inappropriateAPIResponse = NSError(domain: AppErrorDomains.InappropriateAPIResponse.rawValue,
                                                  code: -3,
                                                  userInfo: [NSLocalizedDescriptionKey: "Got inappripriate response from API"])
}
