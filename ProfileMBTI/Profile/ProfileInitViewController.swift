//
//  ProfileInitViewController.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

class ProfileInitViewController: UIViewController {
    
    
    private var profileView = ProfileInitView()
    private var profileModel = ProfileViewModel()
    
    override func loadView() {
        view = profileView
        
        
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        profileView.collectionView.register(ProfileInitCollectionViewCell.self, forCellWithReuseIdentifier: ProfileInitCollectionViewCell.id)
        
        navigationItem.title = profileModel.navigationTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}


extension ProfileInitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileInitCollectionViewCell.id, for: indexPath) as? ProfileInitCollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.setupCast(num: indexPath.item)
        
        return cell
        
        
    }
}
    
