//
//  FeedTC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 18/02/23.
//

import UIKit

// MARK: - TC
class FeedTC: ParentTC {
    
    private let userProfileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_notification_unselected")!, for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_comment")!, for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_share")!, for: .normal)
        return button
    }()
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper method(s)
extension FeedTC {
    
    internal func configureUI() {
        //backgroundColor = .blue
        // Profile Image
        addSubview(userProfileImage)
        userProfileImage.addAnchors(top: YAnchor(anchor: topAnchor, constant: 12),
                                    leading: XAnchor(anchor: leadingAnchor, constant: 12),
                                    widthConstant: SizeConstantAnchor(constant: 40),
                                    heightConstant: SizeConstantAnchor(constant: 40))
        userProfileImage.layer.cornerRadius = 20//userProfileImage.bounds.height / 2
        userProfileImage.layer.masksToBounds = true
        userProfileImage.image = UIImage(named: "venom-7")!
        
        // User name label
        addSubview(userNameLabel)
        userNameLabel.addAnchors(leading: XAnchor(anchor: userProfileImage.trailingAnchor, constant: 10),
                                 centerY: YAnchor(anchor: userProfileImage.centerYAnchor, constant: 0))
        userNameLabel.text = "Hiren Faldu"
        
        // Post Image
        addSubview(postImage)
        postImage.image = UIImage(named: "venom-7")!
        postImage.clipsToBounds = true
        postImage.addAnchors(top: YAnchor(anchor: userProfileImage.bottomAnchor, constant: 10),
                             leading: XAnchor(anchor: userProfileImage.leadingAnchor, constant: 0),
                             trailing: XAnchor(anchor: trailingAnchor, constant: -12),
                             heightConstant: SizeConstantAnchor(constant: 150))
        
        // Buttons
        let buttonStack = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .center
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.spacing = 10
        addSubview(buttonStack)
        buttonStack.addAnchors(top: YAnchor(anchor: postImage.bottomAnchor, constant: 0),
                               leading: XAnchor(anchor: leadingAnchor, constant: 12),
                               heightConstant: SizeConstantAnchor(constant: 40))
        // Like label
        addSubview(likeLabel)
        likeLabel.addAnchors(top: YAnchor(anchor: buttonStack.bottomAnchor, constant: 5),
                             leading: XAnchor(anchor: userProfileImage.leadingAnchor, constant: 0))
        likeLabel.text = "44 likes"
        // Caption label
        addSubview(captionLabel)
        captionLabel.addAnchors(top: YAnchor(anchor: likeLabel.bottomAnchor, constant: 5),
                                bottom: YAnchor(anchor: bottomAnchor, constant: -10),
                                leading: XAnchor(anchor: userProfileImage.leadingAnchor, constant: 0),
                                trailing: XAnchor(anchor: trailingAnchor, constant: 12))
        captionLabel.text = "Hello there, I hope you are doing well...Hello there, I hope you are doing well... Hello there, I hope you are doing well..."
    }
}
