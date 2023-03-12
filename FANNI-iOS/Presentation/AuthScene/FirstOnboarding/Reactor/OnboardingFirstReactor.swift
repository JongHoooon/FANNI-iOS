//
//  FirstOnboardingReactor.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/18.
//

import ReactorKit
import RxCocoa
import RxSwift

final class FirstOnboardingReactor: Reactor {
    
    enum Action {
        case tapUsedNicknameButton
        case tapNewNicknameButton
        case inputNewNickname(_ newNickname: String)
        case editingDidBegin
        case editingDidEnd
    }
    
    enum Mutation {
        case tapUsedNicknameButton
        case tapNewNicknameButton
        case inputNewNickname(_ newNickname: String)
        case editingDidEnd
        case editingDidBegin
    }
    
    struct State {
        var usedNicknameButton: Bool = false
        var newNicknameButton: Bool = false
        var newNickname: String = ""
        var isReponder: Bool = false
    }
    
    let initialState = State()
    
    init() {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapUsedNicknameButton:
            return .just(.tapUsedNicknameButton)
        case .tapNewNicknameButton:
            return .just(.tapNewNicknameButton)
        case .inputNewNickname(let nickname):
            return .just(.inputNewNickname(nickname))
        case .editingDidEnd:
            return .just(.editingDidEnd)
        case .editingDidBegin:
            return .just(.editingDidBegin)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .tapUsedNicknameButton:
            state.usedNicknameButton.toggle()
            state.newNicknameButton = false
            state.isReponder = false
        case .tapNewNicknameButton:
            state.newNicknameButton.toggle()
            state.usedNicknameButton = false
            state.isReponder = state.newNicknameButton
        case .inputNewNickname(let nickname):
            state.newNickname = nickname
        case .editingDidEnd:
            state.isReponder = false
        case .editingDidBegin:
            state.isReponder = true
        }
        return state
    }
}
