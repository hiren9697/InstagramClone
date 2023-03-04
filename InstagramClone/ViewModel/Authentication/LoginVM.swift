//
//  LoginVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import UIKit

final class LoginVM {
    let emailVM = TFVM(placeholder: "Email Address",
                       keyboardType: .emailAddress,
                       returnKey: .next,
                       isSecureTextEntry: false)
    let passwordVM = TFVM(placeholder: "Password",
                          keyboardType: .asciiCapable,
                          returnKey: .done,
                          isSecureTextEntry: true)
    
    func validateInputs()-> TextValidationResult {
        let validator = TextValidator()
        let email = emailVM.text
        let password = passwordVM.text
        if validator.isEmpty(email) {
            return .error(message: "Please enter email")
        } else if validator.isEmpty(password) {
            return .error(message: "Please enter password")
        } else if !validator.isValidEmailAddress(email) {
            return .error(message: "Please enter valid email")
        } else if !validator.isValidPassword(password) {
            return .error(message: "Please enter valid password")
        } else {
            return .success
        }
    }
}
