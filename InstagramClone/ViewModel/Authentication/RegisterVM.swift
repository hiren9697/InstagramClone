//
//  RegistrationVM.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import UIKit

final class RegisterVM {
    var webServiceOperationStatus: Observable<WebServiceOperationStatus> = Observable(.idle)
    var textValidationMessage: Observable<String?> = Observable(nil)
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
    
    func register(successCompletion: @escaping VoidCallback) {
        if validateInputs() {
            webServiceOperationStatus.value = .loading
            let data = RegisterData(email: emailVM.text,
                                    password: passwordVM.text,
                                    fullName: fullNameVM.text,
                                    userName: usernameVM.text,
                                    profileImage: profileImage)
            AuthService.register(data: data) {[weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(_):
                    Log.success("Successfully registered user")
                    strongSelf.webServiceOperationStatus.value = .idle
                    successCompletion()
                case .failure(let error):
                    Log.error("Failed to register user: \(error.localizedDescription)")
                    strongSelf.webServiceOperationStatus.value = .finishedWithError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func validateInputs()-> Bool {
        let validator = TextValidator()
        let email = emailVM.text
        let fullName = fullNameVM.text
        let userName = usernameVM.text
        let password = passwordVM.text
        let confirmPassword = confirmPasswordVM.text
        if validator.isEmpty(email) {
            textValidationMessage.value = "Please enter email"
            return false
        } else if validator.isEmpty(fullName) {
            textValidationMessage.value = "Please enter fullname"
            return false
        } else if validator.isEmpty(userName) {
            textValidationMessage.value = "Please enter username"
            return false
        } else if validator.isEmpty(password) {
            textValidationMessage.value = "Please enter password"
            return false
        } else if validator.isEmpty(confirmPassword) {
            textValidationMessage.value = "Please enter confirm password"
            return false
        } else if !validator.isValidEmailAddress(email) {
            textValidationMessage.value = "Please enter valid email"
            return false
        } else if !validator.isValidUsername(userName) {
            textValidationMessage.value = "Please enter valid username"
            return false
        } else if !validator.isValidPassword(password) {
            textValidationMessage.value = "Please enter valid password"
            return false
        } else if !validator.isValidPassword(confirmPassword) {
            textValidationMessage.value = "Please enter confirm password"
            return false
        } else if password != confirmPassword {
            textValidationMessage.value = "Password and confirm password don't match"
            return false
        } else {
            return true
        }
    }
}
