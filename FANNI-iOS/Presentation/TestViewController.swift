//
//  TestViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/15.
//

import UIKit
import SnapKit

final class TestViewController: BaseViewController {
    
    let nickName: String = UserManager.nickName
    let id: String = UserManager.snsID
    let email: String = UserManager.email
    let birthday: String = UserManager.birthday
    
    // MARK: - UI
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "환영합니다🎉\n\nID: \(id)\n\nnickName: \(nickName)\n\n\(email)\n\nbirthday: \(birthday)"
        label.textColor = .label
        label.font = .pretendar(weight: ._700, size: 32.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
