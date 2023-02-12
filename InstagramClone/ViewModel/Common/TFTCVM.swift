//
//  TFTCVM.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 18/07/22.
//

import UIKit

// MARK: - List
protocol Validatable {
    func validate()-> Validation
}

// MARK: - TextField VM
class TFTCVM {
    
    var value = ""
    let isSecure: Bool
    let placeholder: String
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    let icon: UIImage
    
    init(isSecure: Bool,
         placeholder: String,
         keyboardType: UIKeyboardType,
         returnKeyType: UIReturnKeyType,
         icon: UIImage) {
        self.isSecure = isSecure
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.icon = icon
    }
}
