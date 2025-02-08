//
//  ProfileInitCollectionViewCell.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

final class ProfileInitCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "ProfileInitCollectionViewCell"
    
    private let mbtiView = UIView()
    private let lable = CustomLabel(boldStyle: false, fontSize: 14, color: ColorList.ligthGray)
    
    
    
    override func configureHierarchy() {
        contentView.addSubview(mbtiView)
        contentView.addSubview(lable)

    }
    
    override func configureLayout() {
        
        mbtiView.snp.makeConstraints { make in

            make.size.equalTo(contentView)
        }
        
        lable.snp.makeConstraints { make in
            make.center.equalTo(mbtiView)
        }


        
    }
    
    override func configureView() {
        
        mbtiView.backgroundColor = .clear
        mbtiView.layer.borderWidth = 1
        mbtiView.clipsToBounds = true
        mbtiView.layer.borderColor = ColorList.ligthGray.cgColor
        
        DispatchQueue.main.async {
            self.mbtiView.layer.cornerRadius = self.mbtiView.frame.width / 2
        }
    }

    func setupCast(num: Int) {
        
        lable.text = "\(num)"
        

    }
    
}
