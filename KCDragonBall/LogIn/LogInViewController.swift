//
//  LogInViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 11/03/25.
//

import UIKit

final class LogInViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let herosListTableViewController = HerosListTableViewController(
            nibName: HerosListTableViewController.identifier,
            bundle: nil
        )
        navigationController?.pushViewController(herosListTableViewController, animated: true)
    }
}
