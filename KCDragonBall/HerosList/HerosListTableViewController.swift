//
//  HerosListTableViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 11/03/25.
//

import UIKit

class HerosListTableViewController: UITableViewController {
    
    static let identifier = String(describing: HerosListTableViewController.self)
    
    // Suponiendo que tienes un arreglo de héroes para mostrar en el TableView
        let heroes = ["Superman", "Batman", "Spiderman", "Iron Man", "Wonder Woman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Registrar la celda para mostrar en el TableView
        tableView.register(
            UINib(nibName: HerosListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HerosListTableViewCell.identifier)
        
        title = "Héroes"
    }
    // MARK: - Table View Data Source
    
    // Número de filas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Devuelve el número de filas que quieres mostrar
            return heroes.count  // Usamos el número de héroes como el número de filas
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Deque la celda con el identificador correcto
            let cell = tableView.dequeueReusableCell(withIdentifier: HerosListTableViewCell.identifier, for: indexPath) as! HerosListTableViewCell
            
            // Configura la celda con el nombre del héroe
            cell.heroNameLabel.text = heroes[indexPath.row]
            cell.heroDescriptionLabel.text = "Descripción del héroe \(indexPath.row + 1)" // Esto lo puedes modificar según tus datos
            
            return cell
        }
}
