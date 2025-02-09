//
//  ProfileImageSettingViewController.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    
    private var settingView = ProfileImageSettingView()
    var settingModel = ProfileImageSettingViewModel()
    
    
    override func loadView() {
        view = settingView
        
        settingModel.inputViewDidLoad.value = ()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        settingView.collectionView.delegate = self
        settingView.collectionView.dataSource = self
        settingView.collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.id)
        
        bind()
    }
    
    private func bind() {
        settingModel.outputimageIndex.bind { [weak self] index in
            print("outputimageIndex")
            self?.settingView.imageView.image = ImageList.shared.profileImageList[index]
            self?.navigationItem.title = self?.settingModel.navigationTitle
        }
        
        settingModel.outputimageStatus.lazyBind { [weak self] _ in
            print("outputimageStatus")
            self?.settingView.collectionView.reloadData()
        }
        settingModel.outputChageImage.lazyBind { [weak self] value  in
            self?.settingView.collectionView.reloadItems(at: [IndexPath(row: value.1, section: 0)]) 
            self?.settingView.collectionView.reloadItems(at: [IndexPath(row: value.0, section: 0)])
        }
    }
    
    deinit {
        print("ProfileImageSettingViewController deinit")
    }
    
    
}

// MARK: - CollectionViewDelegate
extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageList.shared.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.id, for: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let tuple =  settingModel.profileStatus[indexPath.item]
        
        cell.imageSetup(tuple: tuple)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        settingModel.inputDidSelected.value = indexPath.item
    }
    
    
}
