//
//  RegistrationVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import UIKit

final class RegisterVM {
    var profileImage: UIImage?
    let emailVM = TFVM(placeholder: "Email Address",
                       keyboardType: .emailAddress,
                       returnKey: .next,
                       isSecureTextEntry: false)
    let fullNameVM = TFVM(placeholder: "Full Name",
                       keyboardType: .asciiCapable,
                       returnKey: .next,
                       isSecureTextEntry: false)
    let usernameVM = TFVM(placeholder: "Username",
                       keyboardType: .asciiCapable,
                       returnKey: .next,
                       isSecureTextEntry: false)
    let passwordVM = TFVM(placeholder: "Password",
                          keyboardType: .asciiCapable,
                          returnKey: .next,
                          isSecureTextEntry: true)
    let confirmPasswordVM = TFVM(placeholder: "Confirm Password",
                          keyboardType: .asciiCapable,
                          returnKey: .done,
                          isSecureTextEntry: true)
    
    func validateInputs()-> TextValidationResult {
        let validator = TextValidator()
        let email = emailVM.text
        let fullName = fullNameVM.text
        let userName = usernameVM.text
        let password = passwordVM.text
        let confirmPassword = confirmPasswordVM.text
        if validator.isEmpty(email) {
            return .error(message: "Please enter email")
        } else if validator.isEmpty(fullName) {
            return .error(message: "Please enter fullname")
        } else if validator.isEmpty(userName) {
            return .error(message: "Please enter username")
        } else if validator.isEmpty(password) {
            return .error(message: "Please enter password")
        } else if validator.isEmpty(confirmPassword) {
            return .error(message: "Please enter confirm password")
        } else if !validator.isValidEmailAddress(email) {
            return .error(message: "Please enter valid email")
        } else if !validator.isValidUsername(userName) {
            return .error(message: "Please enter valid username")
        } else if !validator.isValidPassword(password) {
            return .error(message: "Please enter valid password")
        } else if !validator.isValidPassword(confirmPassword) {
            return .error(message: "Please enter confirm password")
        } else if password != confirmPassword {
            return .error(message: "Password and confirm password don't match")
        } else {
            return .success
        }
    }
}
