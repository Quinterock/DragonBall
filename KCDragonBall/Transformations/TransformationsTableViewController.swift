//
//  TransformationsTableViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 14/03/25.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    static let identifier = String(describing: TransformationsTableViewController.self)

    var hero: Hero?
    var transformations: [Transformation] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TransformationsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TransformationsTableViewCell.identifier)
        title = "Transformaciones"
    }

    // MARK: - Table view data source

    func loadTransformations() {
        guard let hero else { return }
        NetworkModel.shared.getTransformations(for: hero) { [weak self] result in
            switch result {
            case let .success(transformations):
                self?.transformations = transformations
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error obteniendo las transformaciones")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Obtener una celda reciclada para usarla de nuevo
        // casteamos as! TransformationsViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: TransformationsTableViewCell.identifier, for: indexPath) as! TransformationsTableViewCell
        // Obtener una transfomación del array Transformation con cada uno de sus índices
        let transformation = transformations[indexPath.row]
        
        cell.configureTransformationCell(with: transformation)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}
