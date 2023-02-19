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
    
    private lazy var infoLabel1: UILabel = {
        let label = UILabel()
        label.text = "첫 기념일로\n\(UserManager.nickName)님의 생일을\n알려주시겠어요?"
        label.font = .pretendar(weight: ._700, size: 24.0)
        label.textColor = .Font.font1
        label.numberOfLines = 3
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
        textField.layer.borderColor = UIColor.main2.cgColor
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
        button.titleLabel?.font = .pretendar(weight: ._700, size: 16.0)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .main1
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._700, size: 16.0)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .main1
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        configNavigationBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        anniversaryTextField.endEditing(true)
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
        let lunarStackView: UIStackView = {
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
        
        let otherAnniversaryStackView: UIStackView = {
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
        
        let buttonStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [lunarStackView,
                                                           otherAnniversaryStackView])
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
            anniversaryTextField,
            buttonStackView,
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
        
        anniversaryTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel1.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(56.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(anniversaryTextField.snp.bottom).offset(40.0)
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
