//
//  HomeViewController.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 15/05/25.
//

import UIKit
import CoreData
import FirebaseAuth

class HomeViewController: UIViewController {
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let ageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Homeview"
        
        nameLabel.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        emailLabel.frame = CGRect(x: 50, y: 140, width: 300, height: 30)
        ageLabel.frame = CGRect(x: 50, y: 180, width: 300, height: 30)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(ageLabel)
        
        fetchUserData()
//        deleteAllUsers()

        // Logout Button
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Logout", for: .normal)
        signUpButton.frame = CGRect(x: 50, y: 280, width: 300, height: 50)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(signUpButton)
    }

    func fetchUserData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.last {  // Use last user (most recently added)
                nameLabel.text = "Name: \(user.name ?? "No Name")"
                emailLabel.text = "Email: \(user.email ?? "No Email")"
                ageLabel.text = "Age: \(user.age)"
                
            } else {
                nameLabel.text = "No user found."
            }
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
        }
    }

    func deleteAllUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Old users deleted")
        } catch {
            print("Failed to delete users: \(error.localizedDescription)")
        }
    }


    @objc func logout() {
        let mainVc = ViewController()
        if let navController = self.navigationController{
            navController.setViewControllers([mainVc], animated: true)
        }
        print("Log out successful!")
    }
}
