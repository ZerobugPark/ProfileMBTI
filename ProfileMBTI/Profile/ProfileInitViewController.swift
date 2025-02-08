//
//  ProfileInitViewController.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import UIKit

final class ProfileInitViewController: UIViewController {
    
    
    private var profileView = ProfileInitView()
    private var profileModel = ProfileViewModel()
    
    override func loadView() {
        view = profileView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileModel.inputViewDidLoad.value = ()
        profileView.nameTextField.delegate = self

        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        profileView.collectionView.register(ProfileInitCollectionViewCell.self, forCellWithReuseIdentifier: ProfileInitCollectionViewCell.id)

        profileView.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileButtonTapped)))
        profileView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        navigationItem.title = profileModel.navigationTitle
        navigationItem.backButtonTitle = ""
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileModel.inputReset.value = ()
    }
    
    
    private func bind() {
        profileModel.outputChangeStauts.lazyBind { [weak self] _ in
            print("outputMbtiStatus")
            self?.profileView.collectionView.reloadData()

        }
        profileModel.outputTextStatus.lazyBind { [weak self] (msg, stauts) in
            print("outputMbtiStatus")
            self?.profileView.infoLable.text = msg
            self?.profileView.infoLable.textColor = stauts ? ColorList.trueButton :  ColorList.labelFalse
            
        }
        
        profileModel.outputTextFieldStatus.lazyBind { [weak self] (msg, stauts) in
            print("outputTextFieldStatus")
            self?.profileView.infoLable.text = msg
            self?.profileView.infoLable.textColor = stauts ? ColorList.trueButton :  ColorList.labelFalse
            
            self?.profileView.okButton.configuration?.baseBackgroundColor = stauts ? ColorList.trueButton :  ColorList.falseButton
            
            self?.profileView.okButton.isEnabled = stauts
        }
        
        profileModel.outputImageIndex.bind { [weak self] index in
            print("outputImageIndex")
            self?.profileView.imageView.image = ImageList.shared.profileImageList[index]
        }
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        
        guard let windwScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windwScene.windows.first else { return }
        
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        
    }
    

    @objc private func profileButtonTapped(_ sender: UIButton) {
        
        let vc = ProfileImageSettingViewController()
        vc.settingModel.outputimageIndex.value = profileModel.outputImageIndex.value
        vc.settingModel.changedImage =  { [weak self] num in
            self?.profileModel.inputSelectedImage.value = num
        }
        
        
        navigationController?.pushViewController(vc, animated: true)

    }

  
    
    
}


extension ProfileInitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileModel.mbtiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileInitCollectionViewCell.id, for: indexPath) as? ProfileInitCollectionViewCell else { return UICollectionViewCell() }
        
        
        let tuple: (String, Bool) = (profileModel.mbtiList[indexPath.item], profileModel.mbtiStatus[indexPath.item])
        
        
        cell.setup(tuple: tuple)
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        profileModel.inputSelected.value = indexPath.item
    }
}
    
extension ProfileInitViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        profileModel.inputTextField.value = textField.text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        profileModel.inputText.value = string
        
        return profileModel.isOk
    }
    
  
}
