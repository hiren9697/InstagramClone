//
//  ParentVC.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 18/05/22.
//

import UIKit

// MARK: - ParentVC
class ParentVC: UIViewController, LoaderLoadable {
    
    lazy var loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = loaderColor
        return indicator
    }()
    
    var loaderColor: UIColor {
        return AppColor.cWhite
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    deinit {
        App.defaultCenter.removeObserver(self)
    }
}

// MARK: - Alert / Error method(s)
extension ParentVC {
    
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    public func showErrorAlert(error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    public func showErrorAlert(error: AppError) {
        showAlert(title: error.title,
                  message: error.message)
    }
}

