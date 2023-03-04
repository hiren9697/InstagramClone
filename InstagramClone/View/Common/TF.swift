//
//  TF.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 19/02/23.
//

import UIKit

// MARK: - TF
class TF: UIView {
    
    let tf = UITextField()
    let placeholder: String
    let keyboardType: UIKeyboardType
    let returnKey: UIReturnKeyType
    let isSecureTextEntry: Bool
    var nextKeyAction: VoidCallback?
    var didChangeAction: StringCallback?
    
    init(placeholder: String,
         isSecureTextEntry: Bool,
         keyboardType: UIKeyboardType,
         returnKey: UIReturnKeyType) {
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
        self.returnKey = returnKey
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
        tf.isSecureTextEntry = isSecureTextEntry
        tf.keyboardType = keyboardType
        tf.returnKeyType = returnKey
        tf.borderStyle = .none
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        )
        tf.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        addSubview(tf)
        tf.addAnchors(top: YAnchor(anchor: self.topAnchor, constant: 0),
                      bottom: YAnchor(anchor: self.bottomAnchor, constant: 0),
                      leading: XAnchor(anchor: self.leadingAnchor, constant: 8),
                      trailing: XAnchor(anchor: self.trailingAnchor, constant: 8))
        // View
        self.backgroundColor = UIColor(white: 1, alpha: 0.1)
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    @objc func didChange(_ tf: UITextField) {
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
