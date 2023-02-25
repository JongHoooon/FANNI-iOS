//
//  FirstOnboardingViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/18.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxKeyboard

final class FirstOnboardingViewController: BaseViewController, View {
    
    // MARK: - Proprties
    
    let makeAllButtonFalseRelay = PublishRelay<Void>()
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
        
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
        button.titleLabel?.font = .pretendar(weight: ._700, size: 16.0)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .main1
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var newNicknameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "사용하실 이름을 입력해주세요."
        textField.font = .pretendar(weight: ._400, size: 16.0)
        textField.textColor = .Font.font1
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.layer.borderColor = UIColor.deactiveTextField.cgColor
        textField.tintColor = .main1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 56.0))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.isHidden = true
        return textField
    }()
    
    private lazy var usedNicknameStackView: UIStackView = {
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
    
    private lazy var newNicknameStackView: UIStackView = {
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
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usedNicknameStackView,
                                                       newNicknameStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 24.0
        return stackView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        configNavigationBar()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if reactor?.currentState.isReponder ?? false {
            newNicknameTextField.endEditing(true)
        }
    }
    
    // MARK: - Init
    
    init(reactor: FirstOnboardingReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

extension FirstOnboardingViewController {
    
    func bind(reactor: FirstOnboardingReactor) {
        
        // MARK: Action
        
        newNicknameTextField.rx.controlEvent(.editingDidEndOnExit)
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.editingDidEnd }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let editingDidEnd = newNicknameTextField.rx.controlEvent(.editingDidEnd)
            .observe(on: MainScheduler.asyncInstance)
            .share()
        
        let editingDidBegin = newNicknameTextField.rx.controlEvent(.editingDidBegin)
            .observe(on: MainScheduler.asyncInstance)
            .share()
        
        editingDidBegin
            .map { Reactor.Action.editingDidBegin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        editingDidEnd
            .map { Reactor.Action.editingDidEnd }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        usedNicknameCheckButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.tapUsedNicknameButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        newNicknameCheckButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.tapNewNicknameButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        newNicknameTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.inputNewNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // MARK: State

        let usedNicknameButonState = reactor.state.asObservable()
            .subscribe(on: MainScheduler.asyncInstance)
            .map { $0.usedNicknameButton }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            
        let newNicknameButonState = reactor.state.asObservable()
            .subscribe(on: MainScheduler.asyncInstance)
            .map { $0.newNicknameButton }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let newNickname = reactor.state.asObservable()
            .map { $0.newNickname }
            .distinctUntilChanged()
            
        usedNicknameButonState
            .distinctUntilChanged()
            .drive(usedNicknameCheckButton.rx.isCheck)
            .disposed(by: disposeBag)
        
        newNicknameButonState
            .distinctUntilChanged()
            .drive(newNicknameCheckButton.rx.isCheck)
            .disposed(by: disposeBag)
        
        newNicknameButonState
            .map { !$0 }
            .drive(newNicknameTextField.rx.isHiddenAnimatioin)
            .disposed(by: disposeBag)
            
        Observable.combineLatest(usedNicknameButonState.asObservable(), newNicknameButonState.asObservable(), newNickname)
            .map { (usedButton, newButton, newName) -> Bool in
                return usedButton || (newButton && !newName.isEmpty) ? true : false
            }
            .asDriver(onErrorJustReturn: false)
            .drive(nextButton.rx.isEnable)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.isReponder }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(newNicknameTextField.rx.becomeResponder)
            .disposed(by: disposeBag)
            
        // MARK: Event
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let self = self else { return }
                let window = UIApplication.shared.windows.first
                let extra = window!.safeAreaInsets.bottom
                let textFieldY: CGFloat = self.containerView.frame.height - self.newNicknameTextField.frame.maxY
                let keyboardY: CGFloat = keyboardVisibleHeight - extra
                self.scrollView.contentInset.bottom = keyboardY > textFieldY ? keyboardVisibleHeight - extra + 16.0 : 0
            })
            .disposed(by: disposeBag)
        
        editingDidBegin
            .map { return UIColor.main2 }
            .asDriver(onErrorJustReturn: .deactiveTextField)
            .drive(newNicknameTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        editingDidEnd
            .map { return UIColor.deactiveTextField }
            .asDriver(onErrorJustReturn: .main2)
            .drive(newNicknameTextField.rx.borderColor)
            .disposed(by: disposeBag)
    }
}

private extension FirstOnboardingViewController {
    
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
        view.backgroundColor = .systemBackground
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        containerView.addGestureRecognizer(touch)
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [
            progressImageView,
            infoLabel1,
            infoLabel2,
            nicknameStackView,
            newNicknameTextField,
            nextButton
            
        ].forEach { containerView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height)
        }
        
        progressImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.0)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-34.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(56.0)
        }
    }
    
    @objc func tapGesture() {
        self.view.endEditing(true)
    }
    
    // TODO: 화면이동 수정!
    @objc func tapNextButton() {
        UserManager.nickName = newNicknameTextField.text ?? ""
        let vc = SecondOnboardingViewController(reactor: SecondOnboardingReactor())
        navigationController?.pushViewController(vc, animated: true)
        Log.debug("nickname: \(UserManager.nickName)")
    }
}
