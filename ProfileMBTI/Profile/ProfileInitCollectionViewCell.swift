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
    private let lable = CustomLabel(boldStyle: false, fontSize: 14, color: ColorList.darkGray)
    
    
    
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
        mbtiView.layer.borderColor = ColorList.darkGray.cgColor
        
        DispatchQueue.main.async {
            self.mbtiView.layer.cornerRadius = self.mbtiView.frame.width / 2
        }
    }

    func setup(tuple: (String, Bool)) {
        
     
        
        let color = tuple.1 ? ColorList.mainColor : ColorList.white
        let textcolor = tuple.1 ? ColorList.white : ColorList.darkGray
        
        mbtiView.backgroundColor = color
        lable.textColor = textcolor
        lable.text = tuple.0

    }
    
}
