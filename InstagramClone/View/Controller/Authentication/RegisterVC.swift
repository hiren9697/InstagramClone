//
//  RegisterVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 04/03/23.
//

import UIKit

// MARK: - VC
final class RegisterVC: ParentVC {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    private let btnProfileImage = UIButton()
    private let vm = RegisterVM()
    private var tfEmail: TF!
    private var tfFullName: TF!
    private var tfUsername: TF!
    private var tfPassword: TF!
    private var tfConfirmPassword: TF!
    private let btnSignup = UIButton()
    private let lblLogin = UILabel()
    private var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addKeyboardObserver()
        setupBinders()
    }
}

// MARK: - UI method(s)
extension RegisterVC {
    
    private func configureUI() {
        setupNavigationBar()
        setupBackground()
        setupScrollView()
        setupProfileImage()
        setupTextFieldsAndButton()
//        setupForgotPasswordLabel()
        setupLoginLabel()
        setupImagePicker()
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
    
    private func setupProfileImage() {
        // Profile Image View
        let addPhotoImage = UIImage(named: "plus_photo")!.withRenderingMode(.alwaysTemplate)
        profileImageView.image = addPhotoImage
        profileImageView.tintColor = .white
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(profileImageView)
        profileImageView.addAnchors(top: YAnchor(anchor: containerView.topAnchor, constant: 50),
                                    //bottom: YAnchor(anchor: containerView.bottomAnchor, constant: 50),
                                    centerX: XAnchor(anchor: containerView.centerXAnchor, constant: 0),
        widthConstant: SizeConstantAnchor(constant: 100),
        heightConstant: SizeConstantAnchor(constant: 100))
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 2
        // Profile Button
        containerView.addSubview(btnProfileImage)
        btnProfileImage.addTarget(self, action: #selector(profileImageTap(_:)), for: .touchUpInside)
        btnProfileImage.addAnchors(top: YAnchor(anchor: profileImageView.topAnchor, constant: 0),
                                   bottom: YAnchor(anchor: profileImageView.bottomAnchor, constant: 0),
                                   leading: XAnchor(anchor: profileImageView.leadingAnchor, constant: 0),
                                   trailing: XAnchor(anchor: profileImageView.trailingAnchor, constant: 0))
    }
    
    private func setupTextFieldsAndButton() {
        // Email TF
        tfEmail = TF(vm: vm.emailVM)
        tfEmail.nextKeyAction = {[weak self] in
            self?.tfFullName.tf.becomeFirstResponder()
        }
        // FullName TF
        tfFullName = TF(vm: vm.fullNameVM)
        tfFullName.nextKeyAction = {[weak self] in
            self?.tfUsername.tf.becomeFirstResponder()
        }
        // Username TF
        tfUsername = TF(vm: vm.usernameVM)
        tfUsername.nextKeyAction = {[weak self] in
            self?.tfPassword.tf.becomeFirstResponder()
        }
        // Password TF
        tfPassword = TF(vm: vm.passwordVM)
        tfPassword.nextKeyAction = {[weak self] in
            self?.tfConfirmPassword.tf.becomeFirstResponder()
        }
        // Confirm Password TF
        tfConfirmPassword = TF(vm: vm.confirmPasswordVM)
        tfConfirmPassword.nextKeyAction = {[weak self] in
            self?.tfConfirmPassword.tf.resignFirstResponder()
        }
        // Login button
        btnSignup.translatesAutoresizingMaskIntoConstraints = false
        btnSignup.setTitle("Signup", for: .normal)
        btnSignup.setTitleColor(.purple, for: .normal)
        btnSignup.backgroundColor = .white
        btnSignup.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnSignup.layer.cornerRadius = 4
        btnSignup.layer.masksToBounds = true
        btnSignup.addTarget(self, action: #selector(signupTap(_:)), for: .touchUpInside)
        containerView.addSubview(btnSignup)
        btnSignup.addAnchors(heightConstant: SizeConstantAnchor(constant: 50))
        // Stack view
        let tfStackView = UIStackView(arrangedSubviews: [tfEmail, tfFullName, tfUsername, tfPassword, tfConfirmPassword, btnSignup])
        tfStackView.spacing = 20
        tfStackView.axis = .vertical
        tfStackView.alignment = .fill
        tfStackView.distribution = .fillEqually
        containerView.addSubview(tfStackView)
        tfStackView.addAnchors(top: YAnchor(anchor: profileImageView.bottomAnchor, constant: 20),
                               //bottom: YAnchor(anchor: containerView.bottomAnchor, constant: 0),
                           leading: XAnchor(anchor: containerView.leadingAnchor, constant: 20),
                           trailing: XAnchor(anchor: containerView.trailingAnchor, constant: -20))
    }
    
    private func setupLoginLabel() {
        func setLoginText() {
            let text = NSMutableAttributedString(string: "Already have an account? ",
                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                       NSAttributedString.Key.foregroundColor: UIColor.white])
            text.append(NSAttributedString(string: "Log In",
                                           attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                        NSAttributedString.Key.foregroundColor: UIColor.white]))
            lblLogin.attributedText = text
        }
        
        func getTopAnchorConstant()-> CGFloat {
            guard let stack = btnSignup.superview as? UIStackView else {
                return 0
            }
            containerView.layoutIfNeeded()
            let spaceTillSignup = stack.frame.origin.y + stack.frame.height
            let labelHeight: CGFloat = lblLogin.frame.height
            let bottomSpace: CGFloat = 10
            let safeAreaSpace: CGFloat = Geometry.topSafearea + Geometry.bottomSafearea
            let space = view.frame.height - (spaceTillSignup + labelHeight + bottomSpace + safeAreaSpace)
            return max(space, 30)
        }

        setLoginText()
        lblLogin.numberOfLines = 0
        lblLogin.textAlignment = .center
        lblLogin.translatesAutoresizingMaskIntoConstraints = false
        lblLogin.isUserInteractionEnabled = true
        lblLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginTap(_:))))
        containerView.addSubview(lblLogin)
        lblLogin.addAnchors(top: YAnchor(anchor: btnSignup.bottomAnchor, constant: getTopAnchorConstant()),
                             bottom: YAnchor(anchor: containerView.bottomAnchor, constant: 0),
                             leading: XAnchor(anchor: containerView.leadingAnchor, constant: 10),
                             trailing: XAnchor(anchor: containerView.trailingAnchor, constant: -10),
                             centerX: XAnchor(anchor: containerView.centerXAnchor, constant: 0))
    }
    
    private func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
}

// MARK: - Action(s)
extension RegisterVC {
    
    @objc func profileImageTap(_ sender: UIButton) {
        view.endEditing(true)
        showImageSelectionAlert()
    }
    
    @objc func signupTap(_ sender: UIButton) {
        view.endEditing(true)
        vm.register {[weak self] in
            let feedVC = FeedVC()
            self?.navigationController?.pushViewController(feedVC, animated: true)
        }
    }
    
    @objc func loginTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        let text: NSString = lblLogin.attributedText!.string as NSString
        let range = text.range(of: "Log In")
        if sender.didTapAttributedTextInLabel(label: lblLogin, inRange: range) {
            // Navigate to signup
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Helper method(s)
extension RegisterVC {
    
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
                strongSelf.hideLoader()
                Toast.shared.show(message)
            }
        }
    }
    
    private func showImageSelectionAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Choose image source",
                                      preferredStyle: .actionSheet)
        let photosAction = UIAlertAction(title: "Photos", style: .default) {[weak self] _ in
            PermissionManager.shared.requestPhotoPermission {[weak self] status, isGranted in
                DispatchQueue.main.async {[weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.imagePicker.sourceType = .photoLibrary
                    strongSelf.present(strongSelf.imagePicker, animated: true)
                }
            }
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {[weak self] _ in
            PermissionManager.shared.requestCameraPermission {[weak self] status, isGranted in
                DispatchQueue.main.async {[weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.imagePicker.sourceType = .camera
                    strongSelf.present(strongSelf.imagePicker, animated: true)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cance", style: .cancel)
        alert.addAction(photosAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - Keyboard observer
extension RegisterVC {
    
    func addKeyboardObserver() {
        App.defaultCenter.addObserver(self, selector: #selector(handleKeyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        App.defaultCenter.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardShow(_ notification: Notification) {
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = value.cgRectValue
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
        }
    }
    
    @objc func handleKeyboardHide() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Image Picker
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            vm.profileImage = image
            profileImageView.image = image
        }
    }
}
