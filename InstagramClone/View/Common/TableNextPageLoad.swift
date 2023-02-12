//
//  TableNextPageLoad.swift
//  Twitter
//
//  Created by Hiren Faldu on 14/08/22.
//

import UIKit

class TableNextPageLoad: UIView {
    
    let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.tintColor = AppColor.blue
        return activity
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColor.charcole
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activity, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: Geometry.screenWidth, height: 60)
    }
    
    private func configureUI() {
        addSubview(stack)
        stack.addAnchors(
            centerX: XAnchor(anchor: centerXAnchor, constant: 0),
            centerY: YAnchor(anchor: centerYAnchor, constant: 0)
        )
        titleLabel.text = "Loading next page"
        titleLabel.layoutSubviews()
        stack.layoutSubviews()
    }
    
    public func show() {
        activity.startAnimating()
        stack.isHidden = true
        layoutIfNeeded()
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stack.isHidden = false
            strongSelf.layoutSubviews()
        } completion: { _ in }

    }
    
    public func hide() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stack.isHidden = false
            strongSelf.layoutIfNeeded()
        } completion: {[weak self] _ in
            self?.activity.stopAnimating()
        }
    }
    
    public func updateText(text: String) {
        titleLabel.text = text
        titleLabel.layoutIfNeeded()
        setNeedsLayout()
        layoutIfNeeded()
    }
}
