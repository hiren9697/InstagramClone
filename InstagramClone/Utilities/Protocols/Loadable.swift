//
//  Loadable.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 18/05/22.
//

import UIKit

protocol LoaderLoadable where Self: AnyObject {
    
    var loader: UIActivityIndicatorView { get }
    var loaderColor: UIColor { get }
    
    func showLoader(disableInteraction: Bool, color: UIColor?)
    func hideLoader()
}

// MARK: - ViewController
extension LoaderLoadable where Self: UIViewController {
    
    func showLoader(disableInteraction: Bool = true,
                    color: UIColor? = nil) {
        loader.color = color ?? loaderColor
        showLoaderInternal(in: view, loader: loader,
                           disableInteraction: disableInteraction)
    }
    
    func hideLoader() {
        hideLoaderInternal(in: view,
                           loader: loader)
    }
}

// MARK: - Table View Cell
extension LoaderLoadable where Self: UITableViewCell {

    func showLoader(disableInteraction: Bool,
                    color: UIColor? = nil) {
        loader.color = color ?? loaderColor
        showLoaderInternal(in: contentView, loader: loader,
                           disableInteraction: disableInteraction)
    }

    func hideLoader() {
        hideLoaderInternal(in: contentView,
                           loader: loader)
    }
}

// MARK: - Collection View Cell
extension LoaderLoadable where Self: UICollectionViewCell {

    func showLoader(disableInteraction: Bool,
                    color: UIColor? = nil) {
        loader.color = color ?? loaderColor
        showLoaderInternal(in: contentView,
                           loader: loader,
                           disableInteraction: disableInteraction)
    }

    func hideLoader() {
        hideLoaderInternal(in: contentView,
                           loader: loader)
    }
}

// MARK: - View
extension LoaderLoadable where Self: UIView {

    func showLoader(disableInteraction: Bool,
                    color: UIColor? = nil) {
        loader.color = color ?? loaderColor
        showLoaderInternal(in: self,
                           loader: loader,
                           disableInteraction: disableInteraction)
    }

    func hideLoader() {
        hideLoaderInternal(in: self,
                           loader: loader)
    }
}


// MARK: - General functions
fileprivate func showLoaderInternal(in view: UIView, loader: UIActivityIndicatorView, disableInteraction: Bool) {
    view.isUserInteractionEnabled = !disableInteraction
    view.addSubview(loader)
    loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    loader.alpha = 0
    loader.startAnimating()
    view.layoutIfNeeded()
    UIView.animate(withDuration: 0.25) {
        loader.alpha = 1
        view.layoutIfNeeded()
    }
}

fileprivate func hideLoaderInternal(in view: UIView, loader: UIActivityIndicatorView) {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 0.25,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
        loader.alpha = 0
        view.layoutIfNeeded()
    }, completion: { _ in
        loader.stopAnimating()
        loader.removeFromSuperview()
        view.isUserInteractionEnabled = true
    })
}
