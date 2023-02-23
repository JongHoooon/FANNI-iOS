//
//  SecondOnboardingReactor.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/19.
//

import ReactorKit
import RxCocoa
import RxSwift

enum InputMode {
    case deault
    case other
    case custom
}

final class SecondOnboardingReactor: Reactor {
    
    enum Action {
        case tapLunarButton
        case tapOtherButton
        case changeInputMode(_ mode: InputMode)
        case selectDate(_ date: Date)
    }
    
    enum Mutation {
        case tapLunarButton
        case tapOtherButton
        case changeInputMode(_ mode: InputMode)
        case selectDate(_ date: Date)
    }
    
    struct State {
        var checkLunarButton: Bool = false
        var checkOtherButton: Bool = false
        var selectedDate: String = ""
        var inputMode: InputMode = .deault
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
        case .selectDate(let date):
            return .just(.selectDate(date))
        case .changeInputMode(let mode):
            return .just(.changeInputMode(mode))
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
        case .selectDate(let date):
            state.selectedDate = dateToString(date: date)
        case .changeInputMode(let mode):
            state.inputMode = mode
        }
        return state
    }
}
