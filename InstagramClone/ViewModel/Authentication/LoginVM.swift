//
//  LoginVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import UIKit

final class LoginVM {
    var webServiceOperationStatus: Observable<WebServiceOperationStatus> = Observable(.idle)
    var textValidationMessage: Observable<String?> = Observable(nil)
    let emailVM = TFVM(placeholder: "Email Address",
                       keyboardType: .emailAddress,
                       returnKey: .next,
                       isSecureTextEntry: false)
    let passwordVM = TFVM(placeholder: "Password",
                          keyboardType: .asciiCapable,
                          returnKey: .done,
                          isSecureTextEntry: true)
    
    func login(successCompletion: @escaping VoidCallback) {
        if validateInputs() {
            // Do login
            successCompletion()
        }
    }
    
    func validateInputs()-> Bool {
        let validator = TextValidator()
        let email = emailVM.text
        let password = passwordVM.text
        if validator.isEmpty(email) {
            textValidationMessage.value = "Please enter email"
            return false
        } else if validator.isEmpty(password) {
            textValidationMessage.value = "Please enter password"
            return false
        } else if !validator.isValidEmailAddress(email) {
            textValidationMessage.value = "Please enter valid email"
            return false
        } else if !validator.isValidPassword(password) {
            textValidationMessage.value = "Please enter valid password"
            return false
        } else {
            return true
        }
    }
}
