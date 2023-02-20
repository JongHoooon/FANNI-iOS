//
//  SecondOnboardingReactor.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/19.
//

import ReactorKit
import RxCocoa
import RxSwift

final class SecondOnboardingReactor: Reactor {
    
    enum Action {
        case tapLunarButton
        case tapOtherButton
    }
    
    enum Mutation {
        case tapLunarButton
        case tapOtherButton
    }
    
    struct State {
        var checkLunarButton: Bool = false
        var checkOtherButton: Bool = false
    }
    
    let initialState = State()
    
    init() {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .tapLunarButton:
            return .just(.tapLunarButton)
        case .tapOtherButton:
            return .just(.tapOtherButton)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            
        case .tapLunarButton:
            state.checkLunarButton.toggle()
            state.checkOtherButton = false
        case .tapOtherButton:
            state.checkOtherButton.toggle()
            state.checkLunarButton = false
        }
        return state
    }
}
