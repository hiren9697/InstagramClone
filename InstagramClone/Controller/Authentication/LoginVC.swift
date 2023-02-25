//
//  LoginVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 19/02/23.
//

import UIKit

// MARK: - VC
class LoginVC: ParentVC {
    
    private let iconImageView = UIImageView()
    private let tfEmail = TF(placeholder: "Email",
                             isSecureTextEntry: false,
                             keyboardType: .emailAddress,
                             returnKey: .next)
    private let tfPassword = TF(placeholder: "Password",
                                isSecureTextEntry: true,
                                keyboardType: .asciiCapable,
                                returnKey: .done)
    private let btnLogin = UIButton()
    private let lblForgotPassword = UILabel()
    private let lblSignup = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UI method(s)
extension LoginVC {
    
    private func configureUI() {
        setupNavigationBar()
        setupBackground()
        setupIcon()
        setupTextFieldsAndButton()
        setupForgotPasswordLabel()
        setupSignupLabel()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColor.cPurpleRed.cgColor, AppColor.cBlue.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupIcon() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(named: "ic_instagram_logo_white")!
        view.addSubview(iconImageView)
        iconImageView.addAnchors(top: YAnchor(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 32),
                                 centerX: XAnchor(anchor: view.centerXAnchor, constant: 0))
    }
    
    private func setupTextFieldsAndButton() {
        // Email TF
        tfEmail.nextKeyAction = {[weak self] in
            self?.tfPassword.tf.becomeFirstResponder()
        }
        // Password TF
        tfPassword.nextKeyAction = {[weak self] in
            self?.tfPassword.tf.resignFirstResponder()
        }
        // Login button
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.setTitleColor(.purple, for: .normal)
        btnLogin.backgroundColor = .white
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnLogin.layer.cornerRadius = 4
        btnLogin.layer.masksToBounds = true
        btnLogin.addTarget(self, action: #selector(loginTap(_:)), for: .touchUpInside)
        view.addSubview(btnLogin)
        btnLogin.addAnchors(heightConstant: SizeConstantAnchor(constant: 50))
        // Stack view
        let tfStackView = UIStackView(arrangedSubviews: [tfEmail, tfPassword, btnLogin])
        tfStackView.spacing = 20
        tfStackView.axis = .vertical
        tfStackView.alignment = .fill
        tfStackView.distribution = .fillEqually
        view.addSubview(tfStackView)
        tfStackView.addAnchors(top: YAnchor(anchor: iconImageView.bottomAnchor, constant: 20),
                           leading: XAnchor(anchor: view.leadingAnchor, constant: 20),
                           trailing: XAnchor(anchor: view.trailingAnchor, constant: -20))
    }
    
    private func setupForgotPasswordLabel() {
        let stackView = btnLogin.superview as! UIStackView
        setForgotPasswordText()
        lblForgotPassword.numberOfLines = 0
        lblForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        lblForgotPassword.isUserInteractionEnabled = true
        lblForgotPassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTap(_:))))
        view.addSubview(lblForgotPassword)
        lblForgotPassword.addAnchors(top: YAnchor(anchor: stackView.bottomAnchor, constant: 35),
                                     centerX: XAnchor(anchor: view.centerXAnchor, constant: 0))
    }
    
    private func setupSignupLabel() {
        setSignupText()
        lblSignup.numberOfLines = 0
        lblSignup.translatesAutoresizingMaskIntoConstraints = false
        lblSignup.isUserInteractionEnabled = true
        lblSignup.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signupTap(_:))))
        view.addSubview(lblSignup)
        lblSignup.addAnchors(bottom: YAnchor(anchor: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                             centerX: XAnchor(anchor: view.centerXAnchor, constant: 0))
    }
    
    private func setForgotPasswordText() {
        let text = NSMutableAttributedString(string: "Forgot your password? ",
                                      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                   NSAttributedString.Key.foregroundColor: UIColor.white])
        text.append(NSAttributedString(string: "Get help signing in",
                                       attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))
        lblForgotPassword.attributedText = text
    }
    
    private func setSignupText() {
        let text = NSMutableAttributedString(string: "Don't have an account? ",
                                      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                   NSAttributedString.Key.foregroundColor: UIColor.white])
        text.append(NSAttributedString(string: "Sign Up",
                                       attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))
        lblSignup.attributedText = text
    }
}

// MARK: - Action(s)
extension LoginVC {
    
    @objc func loginTap(_ sender: UIButton) {
        print("Login tapped")
    }
    
    @objc func forgotPasswordTap(_ sender: UITapGestureRecognizer) {
        let text: NSString = lblForgotPassword.attributedText!.string as NSString
        let range = text.range(of: "Get help signing in")
        if sender.didTapAttributedTextInLabel(label: lblForgotPassword, inRange: range) {
            print("Navigate to forgot password")
        }
    }
    
    @objc func signupTap(_ sender: UITapGestureRecognizer) {
        let text: NSString = lblSignup.attributedText!.string as NSString
        let range = text.range(of: "Sign Up")
        if sender.didTapAttributedTextInLabel(label: lblSignup, inRange: range) {
            print("Navigate to Sign Up")
        }
    }
}


//        NSLayoutConstraint(item: lblForgotPassword,
//                           attribute: .leading,
//                           relatedBy: .lessThanOrEqual,
//                           toItem: view,
//                           attribute: .leading,
//                           multiplier: 1,
//                           constant: 0).isActive = true
//        NSLayoutConstraint(item: lblForgotPassword,
//                           attribute: .trailing,
//                           relatedBy: .greaterThanOrEqual,
//                           toItem: view,
//                           attribute: .trailing,
//                           multiplier: 1,
//                           constant: 0).isActive = true
