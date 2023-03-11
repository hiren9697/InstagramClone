//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 08/03/23.
//

import UIKit
import Kingfisher

enum ProfilePostType {
    case user
    case saved
}

// MARK: - Header
class ProfileHeaderView: UICollectionReusableView {
    
    let profilePicture = UIImageView()
    let lblPostValue = UILabel()
    let lblPostTitle = UILabel()
    let lblFollowerValue = UILabel()
    let lblFollowerTitle = UILabel()
    let lblFollowingValue = UILabel()
    let lblFollowingTitle = UILabel()
    let lblUsername = UILabel()
    let lblBio = UILabel()
    let btnEditProfile = UIButton()
    let btnPosts = UIButton()
    let btnSaved = UIButton()
    var postType: ProfilePostType = .user
    let postTypeSeperator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .green
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI method(s)
extension ProfileHeaderView {
    
    private func configureUI() {
        setupProfilePictureAndUserInfo()
        setupUsernameLabel()
        setupBioLabel()
        setupEditProfileButton()
        setupButtons()
        setupPostTypeSeparator()
    }
    
    private func setupProfilePictureAndUserInfo() {
        // Profile picture
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.addAnchors(widthConstant: SizeConstantAnchor(constant: 96),
                                  heightConstant: SizeConstantAnchor(constant: 96))
        profilePicture.layer.cornerRadius = 48
        profilePicture.layer.masksToBounds = true
        profilePicture.backgroundColor = .red
        
        // Posts label
        lblPostTitle.translatesAutoresizingMaskIntoConstraints = false
        lblPostTitle.font = AppFont.regular.withSize(13)
        lblPostTitle.textColor = AppColor.cPrimaryTextColor
        lblPostTitle.text = "Posts"
        lblPostValue.translatesAutoresizingMaskIntoConstraints = false
        lblPostValue.font = AppFont.semibold.withSize(16)
        lblPostValue.textColor = AppColor.cPrimaryTextColor
        lblPostValue.text = "112"
        let stackPostText = UIStackView(arrangedSubviews: [lblPostValue, lblPostTitle])
        stackPostText.axis = .vertical
        stackPostText.alignment = .center
        stackPostText.distribution = .fill
        
        // Follower label
        lblFollowerTitle.translatesAutoresizingMaskIntoConstraints = false
        lblFollowerTitle.font = AppFont.regular.withSize(13)
        lblFollowerTitle.textColor = AppColor.cPrimaryTextColor
        lblFollowerTitle.text = "Followers"
        lblFollowerValue.translatesAutoresizingMaskIntoConstraints = false
        lblFollowerValue.font = AppFont.semibold.withSize(16)
        lblFollowerValue.textColor = AppColor.cPrimaryTextColor
        lblFollowerValue.text = "112"
        let stackFollowerText = UIStackView(arrangedSubviews: [lblFollowerValue, lblFollowerTitle])
        stackFollowerText.axis = .vertical
        stackFollowerText.alignment = .center
        stackFollowerText.distribution = .fill
        
        // Following label
        lblFollowingTitle.translatesAutoresizingMaskIntoConstraints = false
        lblFollowingTitle.font = AppFont.regular.withSize(13)
        lblFollowingTitle.textColor = AppColor.cPrimaryTextColor
        lblFollowingTitle.text = "Following"
        lblFollowingValue.translatesAutoresizingMaskIntoConstraints = false
        lblFollowingValue.font = AppFont.semibold.withSize(16)
        lblFollowingValue.textColor = AppColor.cPrimaryTextColor
        lblFollowingValue.text = "112"
        let stackFollowingText = UIStackView(arrangedSubviews: [lblFollowingValue, lblFollowingTitle])
        stackFollowingText.axis = .vertical
        stackFollowingText.alignment = .center
        stackFollowingText.distribution = .fill

        
        let stackView = UIStackView(arrangedSubviews: [profilePicture, stackPostText, stackFollowerText, stackFollowingText])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.addAnchors(top: YAnchor(anchor: self.topAnchor, constant: 10),
                             //bottom: YAnchor(anchor: self.bottomAnchor, constant: -10),
                             leading: XAnchor(anchor: self.leadingAnchor, constant: 11),
                             trailing: XAnchor(anchor: self.trailingAnchor, constant: -22))
    }
    
    private func setupUsernameLabel() {
        let stack = profilePicture.superview as! UIStackView
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.font = AppFont.semibold.withSize(12)
        lblUsername.textColor = AppColor.cPrimaryTextColor
        lblUsername.text = "User name"
        addSubview(lblUsername)
        lblUsername.addAnchors(top: YAnchor(anchor: stack.bottomAnchor, constant: 12),
//                               bottom: YAnchor(anchor: bottomAnchor, constant: -10),
                               leading: XAnchor(anchor: self.leadingAnchor, constant: 16),
                               trailing: XAnchor(anchor: self.trailingAnchor, constant: -16))
    }
    
    private func setupBioLabel() {
        lblBio.translatesAutoresizingMaskIntoConstraints = false
        lblBio.numberOfLines = 0
        lblBio.font = AppFont.regular.withSize(12)
        lblBio.textColor = AppColor.cPrimaryTextColor
        lblBio.text = "Digital goodies designer @pixsellz\nEverything is designed."
        addSubview(lblBio)
        lblBio.addAnchors(top: YAnchor(anchor: lblUsername.bottomAnchor, constant: 1),
                          //bottom: YAnchor(anchor: bottomAnchor, constant: -10),
                          leading: XAnchor(anchor: lblUsername.leadingAnchor, constant: 0),
                          trailing: XAnchor(anchor: lblUsername.trailingAnchor, constant: 0))
    }
    
    private func setupEditProfileButton() {
        btnEditProfile.translatesAutoresizingMaskIntoConstraints = false
        btnEditProfile.addTarget(self, action: #selector(editProfile(_:)), for: .touchUpInside)
        btnEditProfile.setTitle("Edit Profile", for: .normal)
        btnEditProfile.backgroundColor = AppColor.cPrimaryBackground
        btnEditProfile.setTitleColor(AppColor.cPrimaryTextColor, for: .normal)
        btnEditProfile.titleLabel?.font = AppFont.semibold.withSize(13)
        btnEditProfile.layer.cornerRadius = 6
        btnEditProfile.layer.masksToBounds = true
        btnEditProfile.layer.borderColor = UIColor.gray.cgColor
        btnEditProfile.layer.borderWidth = 1
        addSubview(btnEditProfile)
        btnEditProfile.addAnchors(top: YAnchor(anchor: lblBio.bottomAnchor, constant: 15),
                                  //bottom: YAnchor(anchor: bottomAnchor, constant: -5),
                                  leading: XAnchor(anchor: lblUsername.leadingAnchor, constant: 0),
                                  trailing: XAnchor(anchor: lblUsername.trailingAnchor, constant: 0),
                                  heightConstant: SizeConstantAnchor(constant: 29))
    }
    
    private func setupButtons() {
        btnPosts.translatesAutoresizingMaskIntoConstraints = false
        btnSaved.translatesAutoresizingMaskIntoConstraints = false
        btnPosts.setImage(UIImage(named: "ic_profile_post_selected"), for: .selected)
        btnPosts.setImage(UIImage(named: "ic_profile_post_unselected"), for: .normal)
        btnPosts.addTarget(self, action: #selector(postTap(_:)), for: .touchUpInside)
        btnSaved.setImage(UIImage(named: "ic_profile_saved_selected"), for: .selected)
        btnSaved.setImage(UIImage(named: "ic_profile_saved_unselected"), for: .normal)
        btnSaved.addTarget(self, action: #selector(savedTap(_:)), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [btnPosts, btnSaved])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        addSubview(stack)
        stack.addAnchors(top: YAnchor(anchor: btnEditProfile.bottomAnchor, constant: 16),
                         //bottom: YAnchor(anchor: bottomAnchor, constant: -5),
                         leading: XAnchor(anchor: leadingAnchor, constant: 0),
                         trailing: XAnchor(anchor: trailingAnchor, constant: 0),
                         heightConstant: SizeConstantAnchor(constant: 44))
        updatePostTypeUI()
    }
    
    private func setupPostTypeSeparator() {
        let stack = btnPosts.superview as! UIStackView
        postTypeSeperator.translatesAutoresizingMaskIntoConstraints = false
        postTypeSeperator.backgroundColor = AppColor.cPrimaryTextColor
        addSubview(postTypeSeperator)
        postTypeSeperator.addAnchors(top: YAnchor(anchor: stack.bottomAnchor, constant: 0),
                                     bottom: YAnchor(anchor: self.bottomAnchor, constant: -5),
                                     leading: XAnchor(anchor: leadingAnchor, constant: 0),
                                     //trailing: XAnchor(anchor: trailingAnchor, constant: 0),
                                     widthConstant: SizeConstantAnchor(constant: self.bounds.width / 2),
                                     heightConstant: SizeConstantAnchor(constant: 1))
    }
    
    private func updatePostTypeUI() {
        btnPosts.isSelected = false
        btnSaved.isSelected = false
        
        UIView.animate(withDuration: 0.25,
                       delay: 0) {[weak self] in
            guard let strongSelf = self else { return }
            switch strongSelf.postType {
            case .user:
                strongSelf.btnPosts.isSelected = true
                strongSelf.postTypeSeperator.transform = .identity
            case .saved:
                strongSelf.btnSaved.isSelected = true
                strongSelf.postTypeSeperator.transform = CGAffineTransform(translationX: strongSelf.bounds.width / 2,
                                                                           y: 0)
            }
            //strongSelf.layoutIfNeeded()
        }
    }
    
    internal func updateUI(vm: ProfileHeaderVM) {
        lblUsername.text = vm.username
        profilePicture.kf.setImage(with: vm.profilePictureURL)
    }
}

// MARK: - Action(s)
extension ProfileHeaderView {
    
    @objc func editProfile(_ sender: UIButton) {
        Log.info("Edit profile")
    }
    
    @objc func postTap(_ sender: UIButton) {
        postType = .user
        updatePostTypeUI()
    }
    
    @objc func savedTap(_ sender: UIButton) {
        postType = .saved
        updatePostTypeUI()
    }
}
