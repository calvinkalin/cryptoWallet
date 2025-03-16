//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 11.03.2025.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bot")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = .poppinsRegular(size: 15)
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        textField.setLeftIcon(UIImage(named: "user")!, tintColor: .orange)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = .poppinsRegular(size: 15)
        textField.borderStyle = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        textField.setLeftIcon(UIImage(named: "password")!, tintColor: .purple)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .poppinsBold(size: 15)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(287)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(174)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(55)
        }
    }
    
    @objc private func loginTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if viewModel.validateCredentials(username: username, password: password) {
            viewModel.login()
            
            switchToMainApp()
        } else {
            showAlert("Ошибка", "Неверный логин или пароль")
        }
    }
    
    private func switchToMainApp() {
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = TabBarFactory.createTabBarController()
        }
    }
    
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UITextField {
    func setLeftIcon(_ icon: UIImage, tintColor: UIColor) {
        let iconView = UIImageView(frame: CGRect(x: 5, y: 5, width: 32, height: 32))
        iconView.image = icon
        iconView.tintColor = tintColor
        
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        iconContainerView.addSubview(iconView)
        
        self.leftView = iconContainerView
        self.leftViewMode = .always
    }
}
