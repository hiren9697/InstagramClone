//
//  ParentVC.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 18/02/23.
//

import UIKit

// MARK: - VC
class ProfileVC: ParentVC {
    
    var collectionView: UICollectionView!
    let vm = ProfileVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBinders()
        fetchUserInfo()
    }
}

// MARK: - UI method(s)
extension ProfileVC {
    
    private func configureUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.headerReferenceSize = CGSize(width: 200, height: 3x00)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(ProfileHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "ProfileHeaderView")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

// MARK: - Helper method(s)
extension ProfileVC {
    
    private func setupBinders() {
        vm.errorMessage.bind {[weak self] observable, message in
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
                Toast.shared.show(message)
            }
        }
        vm.user.bind {[weak self] observable, user in
            self?.collectionView.reloadData()
            if user == nil {
                self?.collectionView.isHidden = true
            } else {
                self?.collectionView.isHidden = false
            }
        }
    }
}

// MARK: - CollectionView method(s)
extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: "ProfileHeaderView",
                                                                   for: IndexPath(row: 0, section: section)) as! ProfileHeaderView
        return view.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                   height: UIView.layoutFittingExpandedSize.height),
                                           withHorizontalFittingPriority: .required, // Width is fixed
                                           verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: "ProfileHeaderView",
                                                                   for: indexPath) as! ProfileHeaderView
        if let vm = vm.headerVM {
            view.updateUI(vm: vm)
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (3 * 2)) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - API
extension ProfileVC {
    
    private func fetchUserInfo() {
        vm.fetchCurrentUser()
    }
}
