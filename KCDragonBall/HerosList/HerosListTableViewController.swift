//
//  HerosListTableViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 11/03/25.
//

import UIKit

final class HerosListTableViewController: UITableViewController {
    
    static let identifier = String(describing: HerosListTableViewController.self)
    
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Héroes"
        
        // MARK: - Registrar la celda para mostrar en el TableView
        tableView.register(
            UINib(nibName: HerosListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HerosListTableViewCell.identifier
        )
        loadHeroes()
    }
    
    // MARK: - Table View Data Source
    func loadHeroes() {
        NetworkModel.shared.getHeroes { [weak self] result in
            switch result {
            case let .success(heroes):
                print()
                print()
                print()
                print(heroes.count)
                print()
                print()
                print("Héroes recibidos: \(heroes)")
                print()
                print()
                self?.heroes = heroes
                DispatchQueue.main.async {
                    self?.tableView.reloadData() // Recargamos mla tabla con los héroes
                }
            case .failure(let error):
                print("Error obteniendo los héroes \(error)")
            }
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        return heroes.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Obtener una celda reciclada para usarla de nuevo
            // casteamos a as! HerosListTableViewCell para acceder a sus propiedades segun el héroe
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HerosListTableViewCell.identifier,
                for: indexPath) as! HerosListTableViewCell
            // Obtener un héroe del Array Hero con cada uno de sus índices
            let hero = heroes[indexPath.row]
            
            cell.configureCellWithHero(with: hero)
            return cell
        }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Configura el separador de cada celda (espaciado o margenes)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - Para las celdas seleccionadas
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHero = heroes[indexPath.row]
        let heroDescription = HerosDetailsViewController(nibName: HerosDetailsViewController.identifier, bundle: nil)
        // Igualar la descripción al Héroe seleccionado
        heroDescription.hero = selectedHero
        
        navigationController?.pushViewController(heroDescription, animated: true)
        
    }
}
