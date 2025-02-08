//
//  ProfileImageSettingViewModel.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import Foundation


final class ProfileImageSettingViewModel {
    
    
    
    let navigationTitle = "PROFILE SETTING"

    var changedImage: ((Int) -> Void)?

    var profileStatus: [(Int, Bool)] = []
    var inputViewDidLoad: Observable<Void> = Observable(())
    var inputDidSelected: Observable<Int> = Observable((0))
    
    var outputimageIndex: Observable<Int> = Observable(0)
    var outputimageStatus: Observable<Void> = Observable(())
    var outputChageImage: Observable<(Int,Int)> = Observable((0,0))
    
    private var previousImageIndex = 0
    
    init () {
        print("ProfileImageSettingViewModel init")
        
        
        inputViewDidLoad.lazyBind { [weak self] _ in
            self?.imageViewInit(value: self!.outputimageIndex.value)
        }
        
        inputDidSelected.lazyBind { [weak self] idx  in
            self?.imageSelected(index: idx)
        }
        
    }
    
    
 
    
    private func imageViewInit(value: Int) {
            
        for i in 0..<ImageList.shared.profileImageList.count {
            
            if outputimageIndex.value == i {
                profileStatus.append((i,true))
            } else {
                profileStatus.append((i,false))
            }
        }
        outputimageStatus.value = ()
    }
    
    private func imageSelected(index: Int) {
        
        if outputimageIndex.value != index {
            previousImageIndex = outputimageIndex.value
            outputimageIndex.value = index

            profileStatus[previousImageIndex] = (previousImageIndex, false)
            profileStatus[ outputimageIndex.value] = (outputimageIndex.value, true)
            
            outputChageImage.value = (previousImageIndex, outputimageIndex.value)
            


            //collectionView.reloadData() -> 사실 이게 깔끔하긴 한데
            //imageSet.imageView.image = UIImage(named: ImageList.shared.profileImageList[imageIndex])
            changedImage?(index)

        }
        
        
        
    }
    
    deinit {
        print("ProfileImageSettingViewModel deinit")
    }
    
    
}
