//
//  OnboardingFirstViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/18.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class OnboardingFirstViewController: BaseViewController, View {
    
    // MARK: - Proprties
    
    let makeAllButtonFalseRelay = PublishRelay<Void>()
    
    // MARK: - UI
        
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "progress1")
        
        return imageView
    }()
    
    private lazy var infoLabel1: UILabel = {
        let label = UILabel()
        label.text = "\"\(UserManager.nickName)\"님,\n만나서 반갑습니다!"
        label.font = .pretendar(weight: ._700, size: 24.0)
        label.textColor = .Font.font1
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var infoLabel2: UILabel = {
        let label = UILabel()
        label.text = "FANNI에서 사용하실 이름을 알려주세요.\n모든 가족들에게 이 이름으로 보이니\n가급적 설명이나 모두가 아는 애칭으로 설정해 주세요."
        label.font = .pretendar(weight: ._400, size: 14.0)
        label.textColor = .Font.font3
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var usedNicknameCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        return button
    }()
    
    private lazy var usedNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "\"\(UserManager.nickName)\" 그대로 사용할게요."
        label.font = .pretendar(weight: ._500, size: 16.0)
        label.textColor = .Font.font2
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var newNicknameCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        return button
    }()
    
    private lazy var newNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "새로 설정할게요."
        label.font = .pretendar(weight: ._500, size: 16.0)
        label.textColor = .Font.font2
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .intert(weight: ._700, size: 16.0)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .main1
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var newNicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "사용하실 이름을 입력해주세요."
        textField.font = .pretendar(weight: ._400, size: 16.0)
        textField.textColor = .Font.font1
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.layer.borderColor = UIColor.deactiveTextField.cgColor
        textField.tintColor = .main1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 56.0))
        textField.leftViewMode = .always
        
        return textField
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        configNavigationBar()
    }
    
    // MARK: - Init
    
    init(reactor: OnboardingReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

extension OnboardingFirstViewController {
    
    func bind(reactor: OnboardingReactor) {
        
        // MARK: Action
        
//        utilizationCheckButton.rx.tap
//            .map { Reactor.Action.tapUtilizationCheckButton }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//
//        personalInfoCheckButton.rx.tap
//            .map { Reactor.Action.tapPersonalInfoCheckButton }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        // MARK: State
//
//        let utilizationCheckButtonState = reactor.state.asObservable()
//            .map { $0.utilizationCheckButton }
//            .asDriver(onErrorJustReturn: false)
//            .distinctUntilChanged()
//
//        let personalInfoCheckButtonState = reactor.state.asObservable()
//            .map { $0.personalInfoCheckButton }
//            .asDriver(onErrorJustReturn: false)
//            .distinctUntilChanged()
//
//        utilizationCheckButtonState
//            .drive(utilizationCheckButton.rx.isCheck)
//            .disposed(by: disposeBag)
//
//        personalInfoCheckButtonState
//            .drive(personalInfoCheckButton.rx.isCheck)
//            .disposed(by: disposeBag)
//
//        Observable.combineLatest(
//            utilizationCheckButtonState.asObservable(),
//            personalInfoCheckButtonState.asObservable()
//        )
//        .map { (utilization, personal) -> Bool in
//            return personal && utilization ? true : false
//        }
//        .asDriver(onErrorJustReturn: false)
//        .drive(signinButton.rx.isEnable)
//        .disposed(by: disposeBag)
    }
}

private extension OnboardingFirstViewController {
    
    func configNavigationBar() {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "FANNI"
            label.font = .cafe24Ssurround(size: 18.0)
            label.textColor = .main2
            return label
        }()

        let leftBarItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    func configLayout() {
        let usedNicknameStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [usedNicknameCheckButton, usedNicknameLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            usedNicknameCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            usedNicknameCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            usedNicknameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        let newNicknameStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [newNicknameCheckButton, newNicknameLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 12.0
            
            newNicknameCheckButton.snp.makeConstraints {
                $0.height.width.equalTo(22.0)
            }
            newNicknameCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            newNicknameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return stackView
        }()
        
        let nicknameStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [usedNicknameStackView,
                                                           newNicknameStackView])
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.alignment = .leading
            stackView.spacing = 24.0
            return stackView
        }()

        view.backgroundColor = .systemBackground
        
        [
            progressImageView,
            infoLabel1,
            infoLabel2,
            nicknameStackView,
            newNicknameTextField,
            nextButton
            
        ].forEach { view.addSubview($0) }
        
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40.0)
            $0.centerX.equalToSuperview()
        }
    
        infoLabel1.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().inset(20.0)
        }
        
        infoLabel2.snp.makeConstraints {
            $0.top.equalTo(infoLabel1.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(infoLabel1)
        }
        
        nicknameStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(infoLabel2.snp.bottom).offset(40.0)
        }
        
        newNicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameStackView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalTo(nicknameStackView)
            $0.height.equalTo(56.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(44.0)
        }
    }
    
    @objc func tapRightBarButton() {
        navigationController?.popViewController(animated: true)
    }
}
