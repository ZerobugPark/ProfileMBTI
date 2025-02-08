//
//  ProfileInitView.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

import SnapKit

final class ProfileInitView: BaseView {

    private let circleView = UIView()
    private let subImageView = CustomImageView()
    private let lineView = UIView()
    private let mbtiLable = CustomLabel(boldStyle: true, fontSize: 14, color: ColorList.black)
    
    let imageView = CustomImageView(selected: true)
    let nameTextField = CustomTextField(placeholder: "사용하실 닉네임을 입력해주세요")
    let infoLable = CustomLabel(boldStyle: false, fontSize: 12, color: ColorList.labelFalse)
    let okButton = CustomButton(title: "완료")
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(circleView)
        addSubview(subImageView)
        addSubview(nameTextField)
        addSubview(lineView)
        addSubview(infoLable)
        addSubview(okButton)
        addSubview(mbtiLable)
        
        addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(44)
            make.centerX.equalTo(self)
            make.size.equalTo(self.snp.width).multipliedBy(1.0 / 3.0)
        }
        
        circleView.snp.makeConstraints { make in
            let positionX = imageView.frame.size.width / 1.5
            let positionY = imageView.frame.size.height / 1.5
            make.trailing.equalTo(imageView).inset(positionX)
            make.bottom.equalTo(imageView).inset(positionY)
            make.size.equalTo(imageView.snp.width).multipliedBy(1.0 / 3.5)
        }
        
        subImageView.snp.makeConstraints { make in
            make.center.equalTo(circleView)
            make.size.equalTo(circleView.snp.width).multipliedBy(1.0 / 1.5)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(self).inset(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(32)
            make.size.equalTo(1)
        }
        
        infoLable.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(40)
            make.height.equalTo(15)
        }
        
        
        mbtiLable.snp.makeConstraints { make in
            make.top.equalTo(infoLable.snp.bottom).offset(32)
            make.leading.equalTo(self).offset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLable.snp.bottom).offset(20)
            make.leading.equalTo(mbtiLable.snp.trailing).offset(30)
            make.trailing.equalTo(self).inset(20)
            make.height.equalTo(150)
            
        }
        

        okButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(16)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 8.0)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            
        }
        
   

        
    }
    
    override func configureView() {
        
       
        imageView.isUserInteractionEnabled = true // 뷰에도 터치 가능하게
        
        circleView.backgroundColor = ColorList.mainColor
        
        subImageView.image = UIImage(systemName: "camera.fill")
        subImageView.tintColor = ColorList.white
        subImageView.contentMode = .scaleAspectFit

        
        lineView.backgroundColor = ColorList.darkGray
       
        let text = "2글자 이상 10글자 미만으로 설정해주세요"
        infoLable.text = text
        
        mbtiLable.text = "MBTI"
        
        okButton.isEnabled = false
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
            self.subImageView.layer.cornerRadius = self.subImageView.frame.width / 2
        }
    
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        
        
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return UICollectionViewLayout() }
        
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = window.screen.bounds.size.width
        
        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        let imageCount: CGFloat = 4
        
        let objectWidth = (deviceWidth - ((spacing * (imageCount - 1)) + (inset * 2))) / 6.5
        

        layout.minimumInteritemSpacing = spacing
        
        layout.itemSize = CGSize(width: objectWidth, height: objectWidth)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    deinit {
        print("ProfileInitView Deinit")
    }
}
