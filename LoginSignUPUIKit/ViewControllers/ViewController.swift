//
//  ViewController.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 15/05/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext?
    let loginButton = UIButton()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "Nature")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        //Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 0.8)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.frame = CGRect(x: 180, y: 600, width: 300, height: 50)
        loginButton.addTarget(self, action: #selector(navigateLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        
        //Sign up button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor(red: 168/255, green: 198/255, blue: 134/255, alpha: 0.8)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.frame = CGRect(x: 180, y: 700, width: 300, height: 50)
        signUpButton.addTarget(self, action: #selector(navigateSignup), for: .touchUpInside)
        view.addSubview(signUpButton)
    }
    @objc func navigateLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func navigateSignup() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

