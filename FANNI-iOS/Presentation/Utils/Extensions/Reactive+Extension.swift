//
//  Reactive+Extension.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/14.
//

import Foundation
import RxSwift

// MARK: - Agreement View

extension Reactive where Base: UIButton {
    var isCheck: Binder<Bool> {
        return Binder(self.base) { button, bool in
            switch bool {
            case true: button.setImage(UIImage(named: "checkBox1"), for: .normal)
            case false: button.setImage(UIImage(named: "checkBox0"), for: .normal)
            }
        }
    }
}

extension Reactive where Base: UIButton {
    var isEnable: Binder<Bool> {
        return Binder(self.base) { button, bool in
            switch bool {
            case true:
                button.isEnabled = true
                button.backgroundColor = .main1
            case false:
                button.backgroundColor = .systemGray2
                button.isEnabled = false
            }
        }
    }
}
