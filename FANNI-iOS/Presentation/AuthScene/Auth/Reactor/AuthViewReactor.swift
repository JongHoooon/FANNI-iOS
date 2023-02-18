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
import GoogleSignIn

final class AuthReactor: Reactor {
    
    private let disposeBag = DisposeBag()
    
    enum Action {
        case tapKakaoLogin
        case tapGoogleLogin(view: AuthViewController)
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
        case .tapGoogleLogin(let view):
            handleSignInButton(view: view)
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
                
                let id: String = String(user.id ?? 0)
                let nickName: String = user.kakaoAccount?.profile?.nickname ?? ""
                let email: String = user.kakaoAccount?.email ?? ""
                
                UserManager.snsType = "kakao"
                UserManager.snsID = id
                UserManager.nickName = nickName
                UserManager.email = email
                
                Log.debug("Kakao ID: \(id), Kakao Nickname: \(nickName), email: \(email)")
                
            }, onFailure: { error in
                Log.error("Get info with kakao error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func handleSignInButton(view: AuthViewController) {
        GIDSignIn.sharedInstance.signIn(
            withPresenting: view) { signInResult, error in
                guard let result = signInResult else {
                    guard let error = error else { return }
                    Log.error(error)
                    return
                }
                
                let id: String = result.user.userID ?? ""
                let nickName: String = result.user.profile?.name ?? ""
                let email: String = result.user.profile?.email ?? ""
                
                UserManager.snsType = "google"
                UserManager.snsID = id
                UserManager.nickName = nickName
                UserManager.email = email
                
                Log.debug("Google login success - id: \(id), name: \(nickName), email: \(email)")
                NotificationCenter.default.post(name: .loginSuccess, object: nil)
            }
    }
}
