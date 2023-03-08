//
//  TF.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 19/02/23.
//

import UIKit

class TFVM {
    var text: String = ""
    let placeholder: String
    let keyboardType: UIKeyboardType
    let returnKey: UIReturnKeyType
    let isSecureTextEntry: Bool
    
    init(placeholder: String,
         keyboardType: UIKeyboardType,
         returnKey: UIReturnKeyType,
         isSecureTextEntry: Bool) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.returnKey = returnKey
        self.isSecureTextEntry = isSecureTextEntry
    }
}

// MARK: - TF
class TF: UIView {
    
    let tf = UITextField()
    let vm: TFVM
    var nextKeyAction: VoidCallback?
    var didChangeAction: StringCallback?
    
    init(vm: TFVM) {
        self.vm = vm
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper method(s)
extension TF {
    
    private func configureUI() {
        // TextField
        tf.delegate = self
        tf.isSecureTextEntry = vm.isSecureTextEntry
        tf.keyboardType = vm.keyboardType
        if vm.keyboardType == .emailAddress {
            tf.autocapitalizationType = .none
        }
        tf.returnKeyType = vm.returnKey
        tf.borderStyle = .none
        tf.textColor = AppColor.cPrimaryTextColor
        tf.tintColor = .white
        tf.backgroundColor = .clear
        tf.font = AppFont.regular.withSize(14)
        tf.placeholder = vm.placeholder
//        tf.attributedPlaceholder = NSAttributedString(
//            string: vm.placeholder,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
//        )
        tf.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        addSubview(tf)
        tf.addAnchors(top: YAnchor(anchor: self.topAnchor, constant: 0),
                      bottom: YAnchor(anchor: self.bottomAnchor, constant: 0),
                      leading: XAnchor(anchor: self.leadingAnchor, constant: 8),
                      trailing: XAnchor(anchor: self.trailingAnchor, constant: 8))
        // View
        self.backgroundColor = AppColor.cInputBackground
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.cInputBorder.cgColor
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    @objc func didChange(_ tf: UITextField) {
        vm.text = tf.text!
        didChangeAction?(tf.text!)
    }
}

// MARK: - Delegate method(s)
extension TF: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextKeyAction?()
        return true
    }
}
