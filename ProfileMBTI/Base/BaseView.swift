//
//  BaseView.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/7/25.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
        // 모든 뷰가 동일한 색상의 뷰를 가진다면, 베이스뷰에서 작업하는 것도 괜찮아 보임.
       
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
  
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
