//
//  ProfileViewModel.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import Foundation



class ProfileViewModel {
    
    
    let mbtiList = ["E", "S", "T", "J", "I", "N", "F", "P"]
    
    let navigationTitle = "PROFILE SETTING"
    
    
    var currentIdx = 8
    
    var inputSelected: Observable<Int> = Observable((0))
    var inputText: Observable<String> = Observable((""))
    var inputTextField: Observable<String?> = Observable((nil))
    
    var outputChangeStauts:Observable<Void>  = Observable(())
    var outputTextStatus:Observable<(String, Bool)>  = Observable(("",false))
    var outputTextFieldStatus:Observable<(String, Bool)>  = Observable(("",false))
    
    
    var mbtiStatus = [false, false, false, false, false, false, false, false]
    
    var isOk = true

    
    init() {
        print("ProfileViewModel Init")
        
        inputSelected.lazyBind { [weak self] num in
            print("inputSelected")
            self?.checkMbti(index: num)
        }
        
        inputText.lazyBind { [weak self] str in
            print("inputText")
            self?.validation(str: str)
        }
        
        inputTextField.lazyBind { [weak self] str in
            print("inputTextField")
            self?.validationLength(str: str)
        }
    }
    
    
    private func checkMbti(index: Int) {
        
        if mbtiStatus[index] {
            mbtiStatus[index].toggle()
            outputChangeStauts.value = ()
            return
        }
        
        if index / 4 == 0 {
            
            mbtiStatus[index] = true
            mbtiStatus[index+4] = false
            
        } else {
            mbtiStatus[index] = true
            mbtiStatus[index-4] = false
        }
        currentIdx = index
        outputChangeStauts.value = ()
        print(mbtiStatus)
    }
    
    private func validation(str: String) {
        
        let specialCharacter = ["@","#","$","%"]
        
        var infoMsg = ""
     
     
        
        if specialCharacter.contains(str) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            isOk = false
        } else if let _ = Int(str) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            isOk = false
        } else {
            isOk = true
        }
        
        outputTextStatus.value = (infoMsg, isOk)
        
    }
    
    private func validationLength(str: String?) {
        
        let maxLength = 10
        let minLength = 2
        
        var infoMsg = ""
        
        if isOk {
            if let text = str {
                if text.count >= minLength && text.count <= maxLength {
                    infoMsg = "사용할 수 있는 닉네님이에요"
                    isOk = true
                } else {
                    infoMsg = "2글자 이상 10글자 미만으로 설정해주세요"
                    isOk = false
                }
            }
            outputTextFieldStatus.value = (infoMsg, isOk)
        }
    }
    
    
    
    deinit {
        print("mbtiList deinit")
    }
    
    
    
    
}
