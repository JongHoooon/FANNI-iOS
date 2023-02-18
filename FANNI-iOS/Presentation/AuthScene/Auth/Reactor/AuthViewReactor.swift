//
//  AuthViewReactor.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import ReactorKit
import RxSwift

import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

final class AuthReactor: Reactor {
    
    private let disposeBag = DisposeBag()
    
    enum Action {
        case tapKakaoLogin
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    let initialState = State()
    
    init() {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapKakaoLogin:
            loginWithKakao()
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

// MARK: - Private Method
private extension AuthReactor {
    func loginWithKakao() {
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { [weak self] _ in
                    Log.debug("Login With KakaoTalk success.")
                    
                    self?.getInfoWithKakao()
                    NotificationCenter.default.post(name: .loginSuccess, object: nil)
                }, onError: { error in
                    Log.error("login With KakaoTalk error: \(error)")
                })
                .disposed(by: disposeBag)
        } else {
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext: { [weak self] _ in
                    Log.debug("Login With KakaoAccount sucess.")
                    
                    self?.getInfoWithKakao()
                    NotificationCenter.default.post(name: .loginSuccess, object: nil)
                }, onError: { error in
                    Log.error("login With KakaoAccount error: \(error)")
                })
                .disposed(by: disposeBag)
        }
    }
    
    func getInfoWithKakao() {
        UserApi.shared.rx.me()
            .subscribe(onSuccess: { user in
                
                let id: Int = Int(user.id ?? 0)
                let nickName: String = user.kakaoAccount?.profile?.nickname ?? ""
                let email: String = user.kakaoAccount?.email ?? ""
                let birthDay: String = user.kakaoAccount?.birthday ?? ""
                
                UserManager.kakaoID = id
                UserManager.kakaoNickname = nickName
                UserManager.kakaoEmail = email
                UserManager.birthday = birthDay
                
                Log.debug("Kakao ID: \(id), Kakao Nickname: \(nickName), email: \(email), birthday: \(birthDay)")
                
            }, onFailure: { error in
                Log.error("Get info with kakao error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
