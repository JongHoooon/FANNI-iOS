//
//  KakaoAuthService.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/14.
//

// TODO: 수정 필요
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser
import RxSwift

struct KakaoAuthService {
    
    static let shared = KakaoAuthService()
    
    private init() { }
    
    private let disposeBag = DisposeBag()
    
    /// Kakao 로그인
    
    /// Kakao 로그아웃
    func logoutWithKakao() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted: {
                print("✨ Kakao logout success")
            }, onError: { error in
                print("✨ Kakao logout error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
