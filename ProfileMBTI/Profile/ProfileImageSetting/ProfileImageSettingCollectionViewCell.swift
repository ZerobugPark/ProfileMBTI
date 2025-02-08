//
//  ProfileImageSettingCollectionViewCell.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

private let reuseIdentifier = "Cell"

final class ProfileImageSettingCollectionViewCell: BaseCollectionViewCell {

    static let id = "ProfileImageSettingCollectionViewCell"
    
    let imageView = CustomImageView(selected: false)
    
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
    
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
    
    }
    func imageSetup(tuple: (Int, Bool) ) {
        
        imageView.image = ImageList.shared.profileImageList[tuple.0]  
        if !tuple.1 {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = ColorList.darkGray.cgColor
            imageView.alpha = 0.5
            
        } else {
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = ColorList.mainColor.cgColor
            imageView.alpha = 1
        }
        
        
        
        
    }
    
 
}
