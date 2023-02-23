//
//  SecondOnboardingViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/19.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import DropDown

final class SecondOnboardingViewController: BaseViewController, View {
    
    // MARK: - Proprties
    
    let inputModeRelay = PublishRelay<InputMode>()
    
    // MARK: - UI
    
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "progress2")
        
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 기념일로\n\(UserManager.nickName)님의 생일을\n알려주시겠어요?"
        label.font = .pretendar(weight: ._700, size: 24.0)
        label.textColor = .Font.font1
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var hiddendInfoLabel1: UILabel = {
        let label = UILabel()
        label.text = "어떤 기념일인가요?"
        label.font = .pretendar(weight: ._700, size: 24.0)
        label.textColor = .Font.font1
        label.numberOfLines = 1
        label.isHidden = true
        label.alpha = 0
        return label
    }()
    
    private lazy var hiddenMenuButton: UIButton = {
        let button = UIButton()
        button.setTitle("기념일 선택", for: .normal)
        button.setTitleColor(.Font.font3, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.deactiveTextField.cgColor
        button.layer.cornerRadius = 12.0
        button.titleLabel?.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        button.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
        
        button.isHidden = true
        button.alpha = 0
        
        return button
    }()
    
    private lazy var vectorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "downVector"))
        imageView.isHidden = true
        imageView.alpha = 0
        
        return imageView
    }()
    
    private lazy var dropDown: DropDown = {
        let dropDown = DropDown()
        
        dropDown.borderColor = UIColor.main2.cgColor
        dropDown.borderWidth = 1.0
        dropDown.cornerRadius = 12.0
        let itemList = ["생일", "결혼기념일", "작고일", "입양일", "직접 입력"]
        dropDown.dataSource = itemList
        dropDown.anchorView = hiddenMenuButton
        dropDown.bottomOffset = CGPoint(x: 0, y: hiddenMenuButton.bounds.height - 4)
        dropDown.shadowRadius = 12
        dropDown.shadowColor = .systemGray
        dropDown.backgroundColor = .systemBackground
        dropDown.textFont = .pretendar(weight: ._400, size: 16.0)!
        dropDown.textColor = .Font.font2
        dropDown.selectionBackgroundColor = .deactiveButton
        dropDown.cellHeight = 56.0
        dropDown.width = 160.0
        dropDown.animationduration = 0.2
        
        dropDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.hiddenMenuButton.setTitle(item, for: .normal)
            self.hiddenMenuButton.animateBorderColor(toColor: .deactiveTextField, duration: 0.2)
            self.hiddenMenuButton.setTitleColor(.Font.font1, for: .normal)
            self.vectorRoateReset()
            
            if index == 4 {
                self.inputModeRelay.accept(.custom)
            } else {
                self.inputModeRelay.accept(.other)
            }
            
            UIView.animate(withDuration: 0.5) {
            }
        }
        
        dropDown.cancelAction = { [weak self] in
            guard let self = self else { return }
            // 애니메이션 추가
            self.hiddenMenuButton.animateBorderColor(toColor: .deactiveTextField, duration: 0.2)
            self.vectorRoateReset()
        }
        
        return dropDown
    }()
    
    private lazy var hiddendInfoLabel2: UILabel = {
        let label = UILabel()
        label.text = "기념일 날짜를 알려주세요."
        label.font = .pretendar(weight: ._500, size: 16.0)
        label.textColor = .Font.font2
        label.numberOfLines = 1
        label.isHidden = true
        label.alpha = 0
        return label
    }()
    
    private lazy var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "텍스트를 입력해주세요."
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
        textField.alpha = 0
        
        return textField
    }()
    
    private lazy var lunarCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        return button
    }()
    
    private lazy var lunarLabel: UILabel = {
        let label = UILabel()
        label.text = "음력"
        label.font = .pretendar(weight: ._500, size: 16.0)
        label.textColor = .Font.font2
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var otherAnniversaryCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkBox0"), for: .normal)
        return button
    }()
    
    private lazy var otherAnniversaryLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 기념일로 설정할게요."
        label.font = .pretendar(weight: ._500, size: 16.0)
        label.textColor = .Font.font2
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var anniversaryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "YYYY / MM / DD"
        textField.font = .pretendar(weight: ._700, size: 16.0)
        textField.textColor = .Font.font1
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.layer.borderColor = UIColor.deactiveTextField.cgColor
        textField.tintColor = .main1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 56.0))
        textField.leftViewMode = .always
        textField.inputView = datePicker
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        barButton.tintColor = .main1
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 44.0))
        toolBar.setItems([flexible, barButton], animated: true)
        textField.inputAccessoryView = toolBar
        textField.clearButtonMode = .whileEditing
        textField.tintColor = .clear
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = { [weak self] in
        guard let self = self else { return UIDatePicker() }
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        
        return datePicker
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.main1, for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._700, size: 16.0)
        button.backgroundColor = .Background.background1
        button.layer.borderColor = UIColor.main1.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(tapPreviousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._700, size: 16.0)
        button.backgroundColor = .main1
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var lunarStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lunarCheckButton, lunarLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12.0
        
        lunarCheckButton.snp.makeConstraints {
            $0.height.width.equalTo(22.0)
        }
        lunarCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lunarLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stackView
    }()
    
    private lazy var otherAnniversaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [otherAnniversaryCheckButton, otherAnniversaryLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12.0
        
        otherAnniversaryCheckButton.snp.makeConstraints {
            $0.height.width.equalTo(22.0)
        }
        otherAnniversaryCheckButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        otherAnniversaryLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lunarStackView,
                                                       otherAnniversaryStackView])
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
        view.endEditing(true)
    }
    
    // MARK: - Init
    
    init(reactor: SecondOnboardingReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

extension SecondOnboardingViewController {
    
    func bind(reactor: SecondOnboardingReactor) {
        
        // MARK: Action
        
        lunarCheckButton.rx.tap
            .map { Reactor.Action.tapLunarButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let tapOtherAnniversaryCheckButton = otherAnniversaryCheckButton.rx.tap
            .share()
        
        tapOtherAnniversaryCheckButton
            .map { Reactor.Action.tapOtherButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tapOtherAnniversaryCheckButton
            .map { Reactor.Action.changeInputMode(.other)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inputModeRelay
            .map { Reactor.Action.changeInputMode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        datePicker.rx.date
            .skip(1)
            .map { Reactor.Action.selectDate($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: State
        
        reactor.state.asObservable().map { $0.checkLunarButton }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(lunarCheckButton.rx.isCheck)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.checkOtherButton }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(otherAnniversaryCheckButton.rx.isCheck)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.selectedDate }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] dateString in
                guard let self = self else { return }
                self.anniversaryTextField.text = dateString
            })
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.inputMode }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] mode in
                guard let self = self else { return }
                switch mode {
                case .deault:
                    break
                case .other:
                    self.selectOther()
                case .custom:
                    self.selectCustom()
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension SecondOnboardingViewController {
    
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
        
        [
            progressImageView,
            infoLabel,
            hiddendInfoLabel1,
            hiddenMenuButton,
            hiddendInfoLabel2,
            hiddenTextField,
            vectorImageView,
            anniversaryTextField,
            buttonStackView,
            previousButton,
            nextButton
        ].forEach { view.addSubview($0) }
        
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40.0)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().inset(20.0)
        }
        
        hiddendInfoLabel1.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().inset(20.0)
        }
        
        hiddenMenuButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalTo(hiddendInfoLabel1.snp.bottom).offset(40.0)
            $0.width.equalTo(160.0)
            $0.height.equalTo(56.0)
        }
        
        hiddendInfoLabel2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(hiddenMenuButton.snp.bottom).offset(40.0)
        }
        
        hiddenTextField.snp.makeConstraints {
            $0.top.equalTo(hiddenMenuButton.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(56.0)
        }
        
        vectorImageView.snp.makeConstraints {
            $0.trailing.equalTo(hiddenMenuButton.snp.trailing).offset(-16.0)
            $0.centerY.equalTo(hiddenMenuButton)
        }
        
        anniversaryTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(56.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(anniversaryTextField.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
        
        previousButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.leading.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-34.0)
            $0.width.equalTo((self.view.frame.width - 20*2 - 8)/3)
            $0.height.equalTo(56.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.equalTo(previousButton.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-34.0)
            $0.height.equalTo(56.0)
        }
    }
    
    func vectorRotate() {
        UIView.animate(withDuration: 0.2) {
            let rotate = CGAffineTransform(rotationAngle: .pi)
            self.vectorImageView.transform = rotate
        }
    }
    
    func vectorRoateReset() {
        UIView.animate(withDuration: 0.2) {
            let rotate = CGAffineTransform(rotationAngle: .zero)
            self.vectorImageView.transform = rotate
        }
    }
    
    func selectCustom() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.hiddenTextField.alpha = 1
            self.hiddenTextField.isHidden = false
            self.hiddendInfoLabel2.snp.remakeConstraints {
                $0.top.equalTo(self.hiddenTextField.snp.bottom).offset(40.0)
                $0.leading.trailing.equalToSuperview().inset(20.0)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func selectOther() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.infoLabel.alpha = 0
            self.hiddendInfoLabel1.alpha = 1
            self.hiddendInfoLabel1.isHidden = false
            
            self.otherAnniversaryStackView.alpha = 0
            // self.otherAnniversaryStackView.isHidden
            
            self.hiddendInfoLabel2.alpha = 1
            self.hiddendInfoLabel2.isHidden = false
            
            self.hiddendInfoLabel2.snp.remakeConstraints {
                $0.top.equalTo(self.hiddenMenuButton.snp.bottom).offset(40.0)
                $0.leading.trailing.equalToSuperview().inset(20.0)
            }
            
            self.anniversaryTextField.snp.remakeConstraints {
                $0.top.equalTo(self.hiddendInfoLabel2.snp.bottom).offset(24.0)
                $0.leading.trailing.equalToSuperview().inset(20.0)
                $0.height.equalTo(56.0)
            }
            
            self.view.layoutIfNeeded()
            
            self.hiddenMenuButton.alpha = 1
            self.hiddenMenuButton.isHidden = false
            
            self.vectorImageView.alpha = 1
            self.vectorImageView.isHidden = false
            
            self.hiddenTextField.alpha = 0
        }
    }
    
    @objc func tapRightBarButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapMenuButton() {
        dropDown.show()
        hiddenMenuButton.animateBorderColor(toColor: .main2, duration: 0.5)
        vectorRotate()
    }
    
    @objc func tapPreviousButton() {
        navigationController?.popViewController(animated: true)
    }
}
