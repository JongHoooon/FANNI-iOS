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

final class SecondOnboardingViewController: BaseViewController, View {
    
    // MARK: - Proprties
    
    let makeAllButtonFalseRelay = PublishRelay<Void>()
    
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
           $0.trailing.equalTo(button.imageView!.snp.leading).offset(-4.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(112)
        }
        
        button.isHidden = true
        button.alpha = 0
        
        return button
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
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.infoLabel.alpha = 0
            self.hiddendInfoLabel1.alpha = 1
            self.hiddendInfoLabel1.isHidden = false
            
            self.otherAnniversaryStackView.alpha = 0
            
            self.hiddendInfoLabel2.alpha = 1
            self.hiddendInfoLabel2.isHidden = false
//            self.otherAnniversaryStackView.isHidden = true
            
            self.hiddenMenuButton.alpha = 1
            self.hiddenMenuButton.isHidden = false
            
        }
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
        
        lunarCheckButton.rx.tap
            .map { Reactor.Action.tapLunarButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        otherAnniversaryCheckButton.rx.tap
            .map { Reactor.Action.tapOtherButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: Action
        
        reactor.state.asObservable().map { $0.checkLunarButton }
            .asDriver(onErrorJustReturn: false)
            .drive(lunarCheckButton.rx.isCheck)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable().map { $0.checkOtherButton }
            .asDriver(onErrorJustReturn: false)
            .drive(otherAnniversaryCheckButton.rx.isCheck)
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
        
        anniversaryTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(56.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(anniversaryTextField.snp.bottom).offset(24.0)
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
    
    @objc func tapRightBarButton() {
        navigationController?.popViewController(animated: true)
    }
}
