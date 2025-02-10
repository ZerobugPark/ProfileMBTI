//
//  ProfileImageSettingViewModel.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import Foundation


final class ProfileImageSettingViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let didSelected: Observable<Int> = Observable((0))
    }
    
    struct Output {
        let imageIndex: Observable<Int> = Observable(0)
        let imageStatus: Observable<Void> = Observable(())
        let chageImage: Observable<(Int,Int)> = Observable((0,0))
        
    }

    
    let navigationTitle = "PROFILE SETTING"

    var changedImage: ((Int) -> Void)?

    var profileStatus: [(Int, Bool)] = []

    
  
    private var previousImageIndex = 0
    
    init () {
        print("ProfileImageSettingViewModel init")
        
        input = Input()
        output = Output()
        

        transform()
    }
    
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.imageViewInit(value: self!.output.imageIndex.value)
        }
        
        input.didSelected.lazyBind { [weak self] idx  in
            self?.imageSelected(index: idx)
        }
    }
    
    
    private func imageViewInit(value: Int) {
            
        for i in 0..<ImageList.shared.profileImageList.count {
            
            if output.imageIndex.value == i {
                profileStatus.append((i,true))
            } else {
                profileStatus.append((i,false))
            }
        }
        output.imageStatus.value = ()
    }
    
    private func imageSelected(index: Int) {
        
        if output.imageIndex.value != index {
            previousImageIndex = output.imageIndex.value
            output.imageIndex.value = index
            print(previousImageIndex, output.imageIndex.value)

            profileStatus[previousImageIndex] = (previousImageIndex, false)
            profileStatus[output.imageIndex.value] = (output.imageIndex.value, true)
            
            output.chageImage.value = (previousImageIndex, output.imageIndex.value)
        
            changedImage?(index)

        }
        
        
        
    }
    
    deinit {
        print("ProfileImageSettingViewModel deinit")
    }
    
    
}
