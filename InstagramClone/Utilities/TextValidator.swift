//
//  TextValidator.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import Foundation

internal final class TextValidator {
    
    func isEmpty(_ text: String)-> Bool {
        return text.trimmed.isEmpty
    }
    
    func isValidUsername(_ text: String) -> Bool {
        let usernameRegex = "[0-9a-zA-Z]{3,15}"//"[0-9a-zA-Z_.]{3,15}"
        return NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: text)
    }
        
    func isValidName(_ text: String) -> Bool{
        let nameRegix = "(?:[\\p{L}\\p{M}]|\\d)"
        return NSPredicate(format: "SELF MATCHES %@", nameRegix).evaluate(with: text)
    }
    
    func isValidPassword(_ text: String) -> Bool {
        return text.count > 5 && text.count < 17
    }
    
    func isValidEmailAddress(_ text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
    }

    func isValidContact(_ text: String) -> Bool{
        let contactRegEx = "^[0-9]{10,10}$"
        let contactTest = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        return contactTest.evaluate(with: text)
    }
}
