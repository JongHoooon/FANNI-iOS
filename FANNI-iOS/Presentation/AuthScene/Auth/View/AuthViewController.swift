//
//  ViewController.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/05.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift

final class AuthViewController: BaseViewController, View {
    
    // MARK: - UI
    
    private lazy var firstLabel: UILabel = {
        var label = UILabel()
        label.text = "무료 회원 가입"
        label.font = .pretendar(weight: ._700, size: 16.0)
        label.textColor = .Font.font1
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        var label = UILabel()
        let text = "FANNI를\n이용해보시겠어요?"
        label.text = text
        label.font = .pretendar(weight: ._400, size: 32.0)
        let font = UIFont.cafe24Ssurround(size: 32.0)
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.font, value: font!, range: (text as NSString).range(of: "FANNI"))
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        var button = UIButton()
        button.setTitle("  KakaoTalk으로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 16.0)
        button.setImage(UIImage(named: "kakaoIcon"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.backgroundColor = .kakaoYellow
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        var button = UIButton()
        button.setTitle("  Apple로 시작하기", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .pretendar(weight: ._400, size: 16.0)
        let appleIcon = UIImage(named: "appleIcon")?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
        button.setImage(appleIcon, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.backgroundColor = .label
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        var button = UIButton()
        button.setTitle("  Google로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(rgb: 0x999999).cgColor
        button.titleLabel?.font = .pretendar(weight: ._400, size: 16.0)
        button.setImage(UIImage(named: "googleIcon"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        configNavigationBar()
    }
    
    // MARK: - Init
    
    init(reactor: AuthReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

extension AuthViewController {
    
    func bind(reactor: AuthReactor) {
        
        // MARK: Action
        
        kakaoLoginButton.rx.tap
            .map { Reactor.Action.tapKakaoLogin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        googleLoginButton.rx.tap
            .map { Reactor.Action.tapGoogleLogin(view: self) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: - State
        
        NotificationCenter.default.rx.notification(.loginSuccess)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                let vc = AgreementViewController(reactor: AgreementReactor())
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Method

private extension AuthViewController {
    
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
        
        view.backgroundColor = .Background.background1
        let loginStackView: UIStackView  = {
            let stackView = UIStackView(arrangedSubviews: [
                kakaoLoginButton,
                appleLoginButton,
                googleLoginButton
            ])
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.spacing = 16.0
            [
                kakaoLoginButton,
                appleLoginButton,
                googleLoginButton
            ].forEach {
                $0.snp.makeConstraints {
                    $0.height.equalTo(44.0)
                }
            }
            
            return stackView
        }()
        
        [
            firstLabel,
            secondLabel,
            loginStackView
        ].forEach { view.addSubview($0) }
        
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(24.0)
            $0.centerX.equalToSuperview()
        }
        
        loginStackView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(100.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
    
    @objc func tapKakaoLoginButton() {
        let agreementViewController = AgreementViewController(reactor: AgreementReactor())
        navigationController?.pushViewController(agreementViewController, animated: true)
    }
}
