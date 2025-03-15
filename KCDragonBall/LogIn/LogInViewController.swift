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
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        //  Poner de fondo la imagen
        view.sendSubviewToBack(backgroundImageView)
        labelsConf()
    }
    
    func labelsConf() {
        loginButton.tintColor = .orange
    }
    
    // MARK: - Método Login
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let email = userNameTextField.text
        let password = passwordTextField.text
        
        NetworkModel.shared.login(
            user: email ?? "",
            password: password ?? ""
        ) { result in // Closure que recibe un parametro result cuando termina el login
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
                        self.showErrorMessage("Intente nuevamente")
                    }
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.showErrorMessage("Intente nuevamente")
                }
            }
            
        }
        
    }
    
    // Creacion de alerta
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Credenciales incorrectas", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}


