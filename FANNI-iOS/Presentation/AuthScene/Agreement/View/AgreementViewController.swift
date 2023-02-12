//
//  AgreementViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/12.
//

import UIKit
import SnapKit
import ReactorKit

final class AgreementViewController: BaseViewController, View {
    
    // MARK: - UI
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "약관에 동의하시면\n회원가입이 완료됩니다."
        label.font = .pretendar(weight: ._700, size: 24.0)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입하기", for: .normal)
        button.titleLabel?.font = .intert(weight: ._700, size: 16.0)
        button.titleLabel?.textColor = .systemBackground
        button.backgroundColor = .tint1
        
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var utilizationCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        
        return button
    }()
    
    private lazy var utilizationButton: UIButton = {
        let button = UIButton()
        button.setTitle("이용약관 (필수)", for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 14.0)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private lazy var personalInfoCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        
        return button
    }()
    
    private lazy var personalInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보 처리방침 (필수)", for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 14.0)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private lazy var marketingCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        
        return button
    }()
    
    private lazy var marketingButton: UIButton = {
        let button = UIButton()
        button.setTitle("마케팅 수신 동의 (선택)", for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 14.0)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private lazy var allView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xFBF7F7)
        view.layer.cornerRadius = 10.0
            
        return view
    }()
    
    private lazy var allCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        
        return button
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("약관 전체동의", for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 14.0)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()
    }
    
    // MARK: - Init
    
    init(reactor: AgreementReactor) {
        super.init()
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

extension AgreementViewController {
    
    func bind(reactor: AgreementReactor) {
        
    }
    
}

private extension AgreementViewController {
    
    func configLayout() {
        let utilizationStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [utilizationCheckButton, utilizationButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            utilizationCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            utilizationCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            utilizationButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        let personalInfoStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [personalInfoCheckButton, personalInfoButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            personalInfoCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            personalInfoCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            personalInfoButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        let marketingStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [marketingCheckButton, marketingButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            marketingCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            marketingCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            marketingButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        let agreementVerticalStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [utilizationStackView,
                                                           personalInfoStackView,
                                                           marketingStackView])
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.alignment = .leading
            stackView.spacing = 20.0
            return stackView
        }()
        
        let allStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [allCheckButton, allButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            allCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            allCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            allButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        view.backgroundColor = .systemBackground
        
        [
            infoLabel,
            allView,
            agreementVerticalStackView,
            signinButton
            
        ].forEach { view.addSubview($0) }
        
        allView.addSubview(allStackView)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.leading.equalToSuperview().inset(20.0)
        }
        
        allView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(agreementVerticalStackView.snp.top).offset(-16.0)
            $0.height.equalTo(48.0)
        }
        
        allStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        
        agreementVerticalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(36.0)
            $0.bottom.equalTo(signinButton.snp.top).offset(-80.0)
        }
        
        signinButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(44.0)
        }
        
    }
}
