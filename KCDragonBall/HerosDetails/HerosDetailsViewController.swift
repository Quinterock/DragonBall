//
//  HerosDetailsViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 12/03/25.
//

import UIKit

class HerosDetailsViewController: UIViewController {
    
    static let identifier = String(describing: HerosDetailsViewController.self)
    
    var hero: Hero?
    
    var transformations: [Transformation] = []
    
    @IBOutlet var heroImageDetail: UIImageView!
    
    @IBOutlet var heroNameDetail: UILabel!
    
    @IBOutlet var heroDescriptionDetail: UILabel!
    

    
    @IBAction func transformationsButton(_ sender: UIButton) {
        // Desempaquetar hero - Asegurarse que haya un hero antes de que se llame la función
        
        guard let hero else { return }
        
        NetworkModel.shared.getTransformations(for: hero) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transformations):
//                    self?.transformations = transformations
                    let transformationsVC = TransformationsTableViewController(nibName: TransformationsTableViewController.identifier, bundle: nil)
                    transformationsVC.transformations = transformations
                    self?.navigationController?.pushViewController(transformationsVC, animated: true)
                case .failure(let error):
                    print("Error obteniendo heroe")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
    
    private func configuration() {
        guard let hero else { return }
        heroNameDetail.text = hero.name
        heroDescriptionDetail.text = hero.description
        
        if let url = URL(string: hero.photo) {
            heroImageDetail.setImage(url: url)
        }
        title = hero.name
    }
}
