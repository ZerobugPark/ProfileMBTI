//
//  ProfileViewModel.swift
//  ProfileMBTI
//
//  Created by youngkyun park on 2/8/25.
//

import Foundation



class ProfileViewModel: BaseViewModel {
    
    let mbtiList = ["E", "S", "T", "J", "I", "N", "F", "P"]
    
    let navigationTitle = "PROFILE SETTING"
    let empty = ""
    let info = "2글자 이상 10글자 미만으로 설정해주세요"
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        
        let selected: Observable<Int> = Observable((0))
        let text: Observable<String> = Observable((""))
        let textField: Observable<String?> = Observable((nil))
        let viewDidLoad: Observable<Void> = Observable(())
        let selectedImage: Observable<Int> = Observable((0))
        let reset: Observable<Void> = Observable(())
        
    }
    
    struct Output {
        let changeStauts:Observable<Void>  = Observable(())
        let textStatus:Observable<(String, Bool)>  = Observable(("",false))
        let textFieldStatus:Observable<(String, Bool)>  = Observable(("",false))
        let imageIndex: Observable<Int> = Observable((0))
    }
    
    
    var index = Int.random(in: 0..<ImageList.shared.profileImageList.count)
    
    var mbtiStatus = [false, false, false, false, false, false, false, false]
    
    var isOk = false
    var isButtonOk = false
    var observal = false
    var infoMsg = ""
    
    
    init() {
        print("ProfileViewModel Init")
        input = Input()
        output = Output()
        transform()
        
    }
    
    func transform() {
        
        input.selected.lazyBind { [weak self] num in
            print("inputSelected")
            self?.checkMbti(index: num)
        }
        
        input.text.lazyBind { [weak self] str in
            print("inputText")
            self?.validation(str: str)
        }
        // 텍스트 필드에 대한 설정 처리
        input.textField.lazyBind { [weak self] str in
            print("inputTextField")
            self?.validationLength(str: str)
        }
        // 뷰가 최초 로드시 이미지 설정
        input.viewDidLoad.lazyBind { [weak self] _ in
            print("inputViewDidLoad")
            self?.output.imageIndex.value = self!.index
        }
        
        // 프로필 이미지 설정에서 설정한 이미지
        input.selectedImage.lazyBind { [weak self] index in
            print("inputSelectedImage")
            self?.index = index
            self?.output.imageIndex.value = index
            
        }
        
        // 뒤로가기 버튼 클릭시, 초기화
        input.reset.lazyBind { [weak self] _ in
            self?.mbtiStatus = [false, false, false, false, false, false, false, false]
            self?.output.changeStauts.value = ()
            self?.isButtonOk = false
        }
    }
    
    private func checkMbti(index: Int) {
        
        if mbtiStatus[index] {
            mbtiStatus[index].toggle()
            output.changeStauts.value = ()
            buttonStatusCheck()
            return
        }
        
        if index / 4 == 0 {
            
            mbtiStatus[index] = true
            mbtiStatus[index+4] = false
            
        } else {
            mbtiStatus[index] = true
            mbtiStatus[index-4] = false
        }
        
        buttonStatusCheck()
        output.changeStauts.value = ()
        print(mbtiStatus)
    }
    
    private func buttonStatusCheck() {
        if mbtiStatus.filter({ $0 }).count >= 4 {
            isButtonOk = true
        } else {
            isButtonOk = false
        }
        
        if isButtonOk && isOk {
            observal = true
            infoMsg = "사용할 수 있는 닉네임입니다."
        } else {
            observal = false
            infoMsg = isButtonOk ? "2글자 이상 10글자 미만으로 설정해주세요" : "MBTI를 설정해주세요."
        }
        
        output.textFieldStatus.value = (infoMsg, observal)
    }
    
    private func validation(str: String) {
        
        let specialCharacter = ["@","#","$","%"]
        
        
        if specialCharacter.contains(str) {
            infoMsg = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            isOk = false
        } else if let _ = Int(str) {
            infoMsg = "닉네임에 숫자는 포함할 수 없어요"
            isOk = false
        } else {
            isOk = true
        }
        
        output.textStatus.value = (infoMsg, isOk)
        
    }
    
    private func validationLength(str: String?) {
        
        let maxLength = 10
        let minLength = 2
        
        
        if isOk {
            if let text = str {
                if text.count >= minLength && text.count <= maxLength {
                    isOk = true
                } else  {
                    isOk = false
                }
            }
            if isButtonOk && isOk {
                infoMsg = "사용할 수 있는 닉네님이에요"
                observal = true
            } else {
                infoMsg = isOk ? "MBTI를 설정해주세요." : "2글자 이상 10글자 미만으로 설정해주세요"
                observal = false
            }
            output.textFieldStatus.value = (infoMsg, observal)
        }
    }
    
    
    
    deinit {
        print("mbtiList deinit")
    }
    
    
    
    
}
