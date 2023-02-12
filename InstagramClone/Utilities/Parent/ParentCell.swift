//
//  ParentCell.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 28/05/22.
//

import UIKit

// MARK: - Table Cell
class ParentTC: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none
    }
}

// MARK: - Collection Cell
class ParentCC: UICollectionViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

// MARK: - TC Header Footer
class ParentTableHeader: UITableViewHeaderFooterView {
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
