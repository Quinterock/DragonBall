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
        passwordTextField.isSecureTextEntry = true
    }

    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        
        let email = userNameTextField.text
        let password = passwordTextField.text
        
//        let email = "luisgqr1975@gmail.com"
//        let password = "abcdef"
        if userNameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            // Mostrar un mensaje de error si el campo está vacío
            print()
            print()
            print()
            print("Los campos no pueden estar vacíos.")
            print()
            print()
            print()
            return
        }
        
        NetworkModel.shared.login(
            user: email ?? "",
            password: password ?? ""
        ) { result in
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    if !token.isEmpty {
                        // Crear instancia de HerosListTableVC
                        let herosListTableViewController = HerosListTableViewController(
                            nibName: HerosListTableViewController.identifier,
                            bundle: nil
                        )
                        // Navegar al HerosListTableVC
                        self.navigationController?.pushViewController(herosListTableViewController, animated: true)
                    } else {
                        // Token inválido:
                        print("XXXXXXXXXX")
                        print(email ?? "")
                        print(password ?? "")
                        print("XXXXXXXXXX")
                        self.showErrorMessage("Credenciales incorrectas")
                    }
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    print("XXXXXXXXXX")
                    print(email ?? "")
                    print(password ?? "")
                    print("XXXXXXXXXX")
                    self.showErrorMessage("Credenciales incorrectas")
                }
            }
            
        }
        
    }
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}


