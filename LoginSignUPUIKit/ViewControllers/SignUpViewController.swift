//
//  SignUpViewController.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 15/05/25.
//

import UIKit
import FirebaseAuth
class SignUpViewController: UIViewController {
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let ageTextField = UITextField()
    let messageLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = .systemBackground
        
        // Name
        let nameLabel = UILabel()
        nameLabel.text = "Enter name:"
        nameLabel.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        view.addSubview(nameLabel)
        
        
        nameTextField.placeholder = "Enter your name:"
        nameTextField.borderStyle = .roundedRect
        nameTextField.frame = CGRect(x: 50, y: 140, width: 300, height: 40)
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.cornerRadius = 8
        view.addSubview(nameTextField)
        
        // Email
        let emailLabel = UILabel()
        emailLabel.text = "Enter email:"
        emailLabel.frame = CGRect(x: 50, y: 190, width: 200, height: 30)
        view.addSubview(emailLabel)
        
        
        emailTextField.placeholder = "Enter your email:"
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 50, y: 230, width: 300, height: 40)
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.cornerRadius = 8
        view.addSubview(emailTextField)
        
        // Password
        let passwordLabel = UILabel()
        passwordLabel.text = "Enter password:"
        passwordLabel.frame = CGRect(x: 50, y: 280, width: 200, height: 30)
        view.addSubview(passwordLabel)
        
        passwordTextField.placeholder = "Enter your password:"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 50, y: 320, width: 300, height: 40)
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 8
        view.addSubview(passwordTextField)
        
        // Confirm Password
        let confirmPasswordLabel = UILabel()
        confirmPasswordLabel.text = "Confirm password:"
        confirmPasswordLabel.frame = CGRect(x: 50, y: 370, width: 200, height: 30)
        view.addSubview(confirmPasswordLabel)
        
        confirmPasswordTextField.placeholder = "Confirm your password:"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.frame = CGRect(x: 50, y: 410, width: 300, height: 40)
        confirmPasswordTextField.layer.borderWidth = 0.5
        confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.layer.cornerRadius = 8
        view.addSubview(confirmPasswordTextField)
        
        // Age
        let ageLabel = UILabel()
        ageLabel.text = "Enter age:"
        ageLabel.frame = CGRect(x: 50, y: 460, width: 200, height: 30)
        view.addSubview(ageLabel)
        
        ageTextField.placeholder = "Enter your age:"
        ageTextField.borderStyle = .roundedRect
        ageTextField.keyboardType = .numberPad
        ageTextField.frame = CGRect(x: 50, y: 500, width: 300, height: 40)
        ageTextField.layer.borderWidth = 0.5
        ageTextField.layer.borderColor = UIColor.black.cgColor
        ageTextField.layer.cornerRadius = 8
        view.addSubview(ageTextField)
        
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.frame = CGRect(x: 50, y: 580, width: 300, height: 50)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        //validation message
        messageLabel.textColor = .red
        messageLabel.frame = CGRect(x: 50, y: 650, width: 200, height: 30)
        view.addSubview(messageLabel)
    }
    @objc func signUp() {
        let message = validateInputs()
        if !message.isEmpty {
            messageLabel.text = message
            return
        }

        guard passwordTextField.text == confirmPasswordTextField.text else {
            messageLabel.text = "Password do not match!"
            return
        }

        // ✅ First extract all values
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let ageText = ageTextField.text,
              let age = Int16(ageText) else {
            messageLabel.text = "Please enter valid data"
            return
        }

        // ✅ Then register user using valid values
        let coreDataManager = CoreDataManager()
        coreDataManager.registerUser(name: name, email: email, password: password, age: age)

        messageLabel.textColor = .systemGreen
        messageLabel.text = "Sign up successful"
        print("✅ Sign up successful!")
        navigationController?.popViewController(animated: true)
    }

    
    func validateInputs() -> String{
        let message = ValidationHelper.validateFields(fields: [
            nameTextField.text,
            emailTextField.text,
            passwordTextField.text,
            confirmPasswordTextField.text,
            ageTextField.text
        ])
        return message ?? ""
    }
}

