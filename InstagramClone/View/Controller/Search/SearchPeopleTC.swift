//
//  SearchTC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 11/03/23.
//

import UIKit
import Kingfisher

// MARK: - TC
class SearchPeopleTC: ParentTC {
    
    let profilePicture = UIImageView()
    let lblUsername = UILabel()
    let lblFullname = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI method(s)
extension SearchPeopleTC {
    
    private func configureUI() {
        setupProfilePicture()
        setupLabels()
    }
    
    private func setupProfilePicture() {
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profilePicture)
        profilePicture.addAnchors(top: YAnchor(anchor: contentView.topAnchor, constant: 10),
                                  bottom: YAnchor(anchor: contentView.bottomAnchor, constant: -10),
                                  leading: XAnchor(anchor: contentView.leadingAnchor, constant: 16),
                                  //centerY: YAnchor(anchor: contentView.centerYAnchor, constant: 0),
                                  widthConstant: SizeConstantAnchor(constant: 44),
                                  heightConstant: SizeConstantAnchor(constant: 44))
        profilePicture.layer.cornerRadius = 22
        profilePicture.layer.masksToBounds = true
        profilePicture.backgroundColor = .blue
    }
    
    private func setupLabels() {
        lblUsername.font = AppFont.semibold.withSize(13)
        lblUsername.textColor = AppColor.cPrimaryTextColor
        //lblUsername.textAlignment = .left
        lblFullname.font = AppFont.regular.withSize(13)
        lblFullname.textColor = AppColor.cPrimaryTextColor
        //lblFullname.textAlignment = .left
        lblUsername.text = "username"
        lblFullname.text = "fullname"
        let stack = UIStackView(arrangedSubviews: [lblUsername, lblFullname])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.distribution = .fill
        contentView.addSubview(stack)
        stack.addAnchors(leading: XAnchor(anchor: profilePicture.trailingAnchor, constant: 12),
                         trailing: XAnchor(anchor: contentView.trailingAnchor, constant: -12),
                         centerY: YAnchor(anchor: profilePicture.centerYAnchor, constant: 0))
    }
    
    func updateUI(vm: SearchUserVM) {
        profilePicture.kf.setImage(with: vm.profilePicture)
        lblUsername.text = vm.username
        lblFullname.text = vm.fullname
    }
}
