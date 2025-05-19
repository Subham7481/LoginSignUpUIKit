//
//  LoginViewController.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 15/05/25.
//

import Foundation
import UIKit
class LoginViewController: UIViewController{
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton(type: .system)
    let messageLabel = UILabel()
    let toggleButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground
        
        //Email Field
        let emailLabel = UILabel()
        emailLabel.text = "Enter Email"
        emailLabel.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        view.addSubview(emailLabel)
        
        
        emailTextField.placeholder = "Enter email:"
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 50, y: 140, width: 300, height: 40)
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = 8
        view.addSubview(emailTextField)
        
        //Password Field
        let passwordLabel = UILabel()
        passwordLabel.text = "Enter password:"
        passwordLabel.frame = CGRect(x: 50, y: 190, width: 200, height: 30)
        view.addSubview(passwordLabel)
        
        passwordTextField.placeholder = "Enter password:"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.frame = CGRect(x: 50, y: 230, width: 300, height: 40)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisible), for: .touchUpInside)
        
        passwordTextField.rightView = toggleButton
        passwordTextField.rightViewMode = .always
        
        
        //Login Button
        let button = UIButton(type: .system)
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Login", for: .normal)
        signUpButton.frame = CGRect(x: 50, y: 310, width: 300, height: 50)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        //validation message
        messageLabel.textColor = .red
        messageLabel.frame = CGRect(x: 50, y: 650, width: 200, height: 30)
        view.addSubview(messageLabel)
    }
    @objc func login(){
        let message = validateInputs()
        if !message.isEmpty {
            messageLabel.text = message
            return
        }
        messageLabel.text = ""
        
        let coreDataManager = CoreDataManager()
        let isAuthenticated = coreDataManager.authenticateUser(email: emailTextField.text!, password: passwordTextField.text!)
        
        if isAuthenticated {
            messageLabel.textColor = .systemGreen
            messageLabel.text = "Login sucessful!"
            print("Logged in!")
            
            let homeVc = HomeViewController()
            if let navController = self.navigationController{
                navController.setViewControllers([homeVc], animated: true)
            }
        } else {
            messageLabel.textColor = .red
            messageLabel.text = "Invalid email or password."
            print("Login failed:")
        }
    }
    
    func validateInputs() -> String{
        let message = ValidationHelper.validateFields(fields: [
            emailTextField.text,
            passwordTextField.text,
        ])
        return message ?? ""
    }
    
    @objc func togglePasswordVisible(){
        passwordTextField.isSecureTextEntry.toggle()
        
        let image = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        toggleButton.setImage(UIImage(systemName: image), for: .normal)
    }
}
