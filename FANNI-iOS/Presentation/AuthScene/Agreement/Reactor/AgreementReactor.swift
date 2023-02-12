//
//  AgreementReactor.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import Foundation

import ReactorKit
import RxCocoa
import RxSwift

final class AgreementReactor: Reactor {
    
    enum Action {
        case tapAllCheckButton
        case tapUtilizationCheckButton
        case tapPersonalInfoCheckButton
        case tapMarketingCheckButton

    }
    
    enum Mutation {
        case tapAllCheckButton
        case tapUtilizationCheckButton
        case tapPersonalInfoCheckButton
        case tapMarketingCheckButton
        case makeAllButtonFalse
    }
    
    struct State {
        var allCheckButton: Bool = false
        var utilizationCheckButton: Bool = false
        var personalInfoCheckButton: Bool = false
        var marketingCheckButton: Bool = false
    }
    
    let initialState = State()
    
    init() {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapAllCheckButton:
            return .just(.tapAllCheckButton)
        case .tapUtilizationCheckButton:
            if currentState.allCheckButton {
                return .concat([.just(.makeAllButtonFalse), .just(.tapUtilizationCheckButton)])
            }
            return .just(.tapUtilizationCheckButton)
    
        case .tapPersonalInfoCheckButton:
            if currentState.allCheckButton {
                return .concat([.just(.makeAllButtonFalse), .just(.tapPersonalInfoCheckButton)])
            }
            return .just(.tapPersonalInfoCheckButton)
            
        case .tapMarketingCheckButton:
            if currentState.allCheckButton {
                return .concat([.just(.makeAllButtonFalse), .just(.tapMarketingCheckButton)])
            }
            return .just(.tapMarketingCheckButton)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .tapAllCheckButton:
            if !state.allCheckButton {
                state.utilizationCheckButton = true
                state.personalInfoCheckButton = true
                state.marketingCheckButton = true
            }
            state.allCheckButton.toggle()
        case .tapUtilizationCheckButton:
            state.utilizationCheckButton.toggle()
        case .tapPersonalInfoCheckButton:
            state.personalInfoCheckButton.toggle()
        case .tapMarketingCheckButton:
            state.marketingCheckButton.toggle()
        case .makeAllButtonFalse:
            state.allCheckButton = false
        }
        return state
    }
}
