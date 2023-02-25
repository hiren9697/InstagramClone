//
//  EmptyView.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 09/07/22.
//

import UIKit

// MARK: - Error Type
enum ErrorType {
    case empty, error
    
    var image: UIImage {
        switch self {
        case .empty: return UIImage(named: "empty")!
        case .error: return UIImage(named: "error")!
        }
    }
}

// MARK: - VM
class ErrorVM {
    
    var image: UIImage
    var text: String
    
    init(image: UIImage,
         text: String) {
        self.image = image
        self.text = text
    }
}

// MARK: - View
class ErrorView: UIView {
    
    // UI components
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = AppColor.cCharcole
        return label
    }()
    
    // Properties
    var viewModel: ErrorVM
    
    // Life cycle
    init(viewModel: ErrorVM) {
        self.viewModel = viewModel
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: Geometry.screenWidth,
                                 height: Geometry.screenHeight))
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Must call a designated initializer of the superclass 'UIView'")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

// MARK: - Helper method(s)
extension ErrorView {
    
    private func setupUI() {
        // ImageView
        addSubview(imageView)
        imageView.addAnchors(
            top: YAnchor(anchor: topAnchor, constant: 100),
            centerX: XAnchor(anchor: centerXAnchor, constant: 0)
        )
        
        // Text Label
        addSubview(textLabel)
        textLabel.addAnchors(
            top: YAnchor(anchor: imageView.bottomAnchor, constant: 20),
            leading: XAnchor(anchor: leadingAnchor, constant: 20, priority: UILayoutPriority(750)),
            trailing: XAnchor(anchor: trailingAnchor, constant: -20, priority: UILayoutPriority(750)),
            centerX: XAnchor(anchor: centerXAnchor, constant: 0)
        )
    }
    
    private func setupBinding() {
//        viewModel.text.bind {[weak self] observable, text in
//            self?.textLabel.text = text
//        }
//        viewModel.image.bind {[weak self] observable, image in
//            self?.imageView.image = image
//        }
    }
}
