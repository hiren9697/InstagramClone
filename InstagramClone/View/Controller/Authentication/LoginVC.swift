//
//  LoginVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 19/02/23.
//

import UIKit

// MARK: - VC
final class LoginVC: ParentVC {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let vm = LoginVM()
    private var tfEmail: TF!
    private var tfPassword: TF!
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
        setupScrollView()
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
    
    private func setupScrollView() {
        // Setup scrollview
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addAnchors(top: YAnchor(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                              bottom: YAnchor(anchor: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                              leading: XAnchor(anchor: view.leadingAnchor, constant: 0),
                              trailing: XAnchor(anchor: view.trailingAnchor, constant: 0))
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        // Setup container view
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        containerView.addAnchors(top: YAnchor(anchor: scrollView.contentLayoutGuide.topAnchor, constant: 0),
                                 bottom: YAnchor(anchor: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
                                 leading: XAnchor(anchor: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
                                 trailing: XAnchor(anchor: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
                                 width: LayoutAnchor(anchor: scrollView.frameLayoutGuide.widthAnchor, constant: 0))
    }
    
    private func setupIcon() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(named: "ic_instagram_logo_white")!
        containerView.addSubview(iconImageView)
        iconImageView.addAnchors(top: YAnchor(anchor: containerView.safeAreaLayoutGuide.topAnchor, constant: 32),
                                 centerX: XAnchor(anchor: containerView.centerXAnchor, constant: 0))
    }
    
    private func setupTextFieldsAndButton() {
        // Email TF
        tfEmail = TF(vm: vm.emailVM)
        tfEmail.nextKeyAction = {[weak self] in
            self?.tfPassword.tf.becomeFirstResponder()
        }
        // Password TF
        tfPassword = TF(vm: vm.passwordVM)
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
        containerView.addSubview(btnLogin)
        btnLogin.addAnchors(heightConstant: SizeConstantAnchor(constant: 50))
        // Stack view
        let tfStackView = UIStackView(arrangedSubviews: [tfEmail, tfPassword, btnLogin])
        tfStackView.spacing = 20
        tfStackView.axis = .vertical
        tfStackView.alignment = .fill
        tfStackView.distribution = .fillEqually
        containerView.addSubview(tfStackView)
        tfStackView.addAnchors(top: YAnchor(anchor: iconImageView.bottomAnchor, constant: 20),
                           leading: XAnchor(anchor: containerView.leadingAnchor, constant: 20),
                           trailing: XAnchor(anchor: containerView.trailingAnchor, constant: -20))
    }
    
    private func setupForgotPasswordLabel() {
        func setForgotPasswordText() {
            let text = NSMutableAttributedString(string: "Forgot your password? ",
                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                       NSAttributedString.Key.foregroundColor: UIColor.white])
            text.append(NSAttributedString(string: "Get help signing in",
                                           attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                        NSAttributedString.Key.foregroundColor: UIColor.white]))
            lblForgotPassword.attributedText = text
        }
        
        let stackView = btnLogin.superview as! UIStackView
        setForgotPasswordText()
        lblForgotPassword.numberOfLines = 0
        lblForgotPassword.textAlignment = .center
        lblForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        lblForgotPassword.isUserInteractionEnabled = true
        lblForgotPassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTap(_:))))
        containerView.addSubview(lblForgotPassword)
        lblForgotPassword.addAnchors(top: YAnchor(anchor: stackView.bottomAnchor, constant: 35),
                                     leading: XAnchor(anchor: containerView.leadingAnchor, constant: 10),
                                     trailing: XAnchor(anchor: containerView.trailingAnchor, constant: -10),
                                     centerX: XAnchor(anchor: containerView.centerXAnchor, constant: 0))
    }
    
    private func setupSignupLabel() {
        func setSignupText() {
            let text = NSMutableAttributedString(string: "Don't have an account? ",
                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                       NSAttributedString.Key.foregroundColor: UIColor.white])
            text.append(NSAttributedString(string: "Sign Up",
                                           attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                        NSAttributedString.Key.foregroundColor: UIColor.white]))
            lblSignup.attributedText = text
        }

        func getTopAnchorConstant()-> CGFloat {
            containerView.layoutIfNeeded()
            let spaceTillForgotPassword = lblForgotPassword.frame.origin.y + lblForgotPassword.frame.height
            let labelHeight: CGFloat = lblSignup.frame.height
            let bottomSpace: CGFloat = 10
            let safeAreaSpace: CGFloat = Geometry.topSafearea + Geometry.bottomSafearea
            let space = view.frame.height - (spaceTillForgotPassword + labelHeight + bottomSpace + safeAreaSpace)
            return space
        }
        
        setSignupText()
        lblSignup.numberOfLines = 0
        lblSignup.textAlignment = .center
        lblSignup.translatesAutoresizingMaskIntoConstraints = false
        lblSignup.isUserInteractionEnabled = true
        lblSignup.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signupTap(_:))))
        containerView.addSubview(lblSignup)
        lblSignup.addAnchors(top: YAnchor(anchor: lblForgotPassword.bottomAnchor, constant: getTopAnchorConstant()),
                             bottom: YAnchor(anchor: containerView.bottomAnchor, constant: 0),
                             leading: XAnchor(anchor: containerView.leadingAnchor, constant: 10),
                             trailing: XAnchor(anchor: containerView.trailingAnchor, constant: -10),
                             centerX: XAnchor(anchor: containerView.centerXAnchor, constant: 0))
    }
}

// MARK: - Action(s)
extension LoginVC {
    
    @objc func loginTap(_ sender: UIButton) {
        view.endEditing(true)
        vm.login {
            // Navigate to home
        }
    }
    
    @objc func forgotPasswordTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        let text: NSString = lblForgotPassword.attributedText!.string as NSString
        let range = text.range(of: "Get help signing in")
        if sender.didTapAttributedTextInLabel(label: lblForgotPassword, inRange: range) {
            print("Navigate to forgot password")
        }
    }
    
    @objc func signupTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        let text: NSString = lblSignup.attributedText!.string as NSString
        let range = text.range(of: "Sign Up")
        if sender.didTapAttributedTextInLabel(label: lblSignup, inRange: range) {
            // Navigate to signup
            let registerVC = RegisterVC()
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}

// MARK: - Helper method(s)
extension LoginVC {
    
    private func setupBinders() {
        vm.textValidationMessage.bind {[weak self] observable, message in
            guard let message = message,
            let _ = self else {
                return
            }
            Toast.shared.show(message)
        }
        vm.webServiceOperationStatus.bind {[weak self] observable, status in
            guard let strongSelf = self else { return }
            switch status {
            case .idle:
                strongSelf.hideLoader()
            case .loading:
                strongSelf.showLoader(disableInteraction: true)
            case .finishedWithError(let message):
                Toast.shared.show(message)
            }
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
