//
//  UIViewAnchor+Extension.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 04/06/22.
//

import UIKit

enum ConstraintRelationType {
    case equal, lessthan, greaterthan
}

public struct XAnchor {
    let anchor: NSLayoutXAxisAnchor
    let constant: CGFloat
    let priority: UILayoutPriority?
    
    init(anchor: NSLayoutXAxisAnchor,
         constant: CGFloat,
         priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.constant = constant
        self.priority = priority
    }
}

public struct YAnchor {
    let anchor: NSLayoutYAxisAnchor
    let constant: CGFloat
    let priority: UILayoutPriority?
    
    init(anchor: NSLayoutYAxisAnchor,
         constant: CGFloat,
         priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.constant = constant
        self.priority = priority
    }
}

public struct LayoutAnchor {
    let anchor: NSLayoutDimension
    let constant: CGFloat
    let priority: UILayoutPriority?
    
    init(anchor: NSLayoutDimension,
         constant: CGFloat,
         priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.constant = constant
        self.priority = priority
    }
}

public struct SizeConstantAnchor {
    let constant: CGFloat
    let priority: UILayoutPriority?
    
    init(constant: CGFloat,
         priority: UILayoutPriority? = nil) {
        self.constant = constant
        self.priority = priority
    }
}

extension UIView {
    
    

    
//    public typealias XAnchor = (anchor: NSLayoutXAxisAnchor, constant: CGFloat)
//    public typealias YAnchor = (anchor: NSLayoutYAxisAnchor, constant: CGFloat)
//    public typealias LayoutAnchor = (anchor: NSLayoutDimension, constant: CGFloat)
    
    public func addAnchors(
        top: YAnchor? = nil,
        bottom: YAnchor? = nil,
        leading: XAnchor? = nil,
        trailing: XAnchor? = nil,
        centerX: XAnchor? = nil,
        centerY: YAnchor? = nil,
        width: LayoutAnchor? = nil,
        height: LayoutAnchor? = nil,
        widthConstant: SizeConstantAnchor? = nil,
        heightConstant: SizeConstantAnchor? = nil) {
            translatesAutoresizingMaskIntoConstraints = false
            if let top = top {
                let topConstraint = topAnchor.constraint(
                    equalTo: top.anchor,
                    constant: top.constant)
                if let priority = top.priority {
                    topConstraint.priority = priority
                }
                topConstraint.isActive = true
            }
            if let bottom = bottom {
                let bottomConstraint = bottomAnchor.constraint(equalTo: bottom.anchor, constant: bottom.constant)
                if let priority = bottom.priority {
                    bottomConstraint.priority = priority
                }
                bottomConstraint.isActive = true
            }
            if let leading = leading {
                let leadingConstraint = leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant)
                if let priority = leading.priority {
                    leadingConstraint.priority = priority
                }
                leadingConstraint.isActive = true
                
            }
            if let trailing = trailing {
                let trailingConstraint = trailingAnchor.constraint(equalTo: trailing.anchor, constant: trailing.constant)
                if let priority = trailing.priority {
                    trailingConstraint.priority = priority
                }
                trailingConstraint.isActive = true
            }
            if let centerX = centerX {
                let centerXConstraint = centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant)
                if let priority = centerX.priority {
                    centerXConstraint.priority = priority
                }
                centerXConstraint.isActive = true
            }
            if let centerY = centerY {
                let centerYConstraint = centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant)
                if let priority = centerY.priority {
                    centerYConstraint.priority = priority
                }
                centerYConstraint.isActive = true
            }
            if let width = width {
                let widthConstraint = widthAnchor.constraint(equalTo: width.anchor, constant: width.constant)
                if let priority = width.priority {
                    widthConstraint.priority = priority
                }
                widthConstraint.isActive = true
            }
            if let height = height {
                let heigthConstraint = heightAnchor.constraint(equalTo: height.anchor, constant: height.constant)
                if let priority = height.priority {
                    heigthConstraint.priority = priority
                }
                heigthConstraint.isActive = true
            }
            if let heightConstant = heightConstant {
                let heigthConstraint = heightAnchor.constraint(equalToConstant: heightConstant.constant)
                if let priority = heightConstant.priority {
                    heigthConstraint.priority = priority
                }
                heigthConstraint.isActive = true
            }
            if let widthConstant = widthConstant {
                let widthConstraint = widthAnchor.constraint(equalToConstant: widthConstant.constant)
                if let priority = widthConstant.priority {
                    widthConstraint.priority = priority
                }
                widthConstraint.isActive = true
            }
    }
}
