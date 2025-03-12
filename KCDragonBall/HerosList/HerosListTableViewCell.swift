//
//  HerosListTableViewCell.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 11/03/25.
//

import UIKit

class HerosListTableViewCell: UITableViewCell {
    @IBOutlet var heroNameLabel: UILabel!
    
    @IBOutlet var heroDescriptionLabel: UILabel!
    
    @IBOutlet var heroImageView: UIImageView!
    
    
    static let identifier = String(describing: HerosListTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    // Recibir los Héroes y poner cada celda con los datos de cada uno
    func configureCellWithHero(with hero: Hero) {
        print()
        print()
        print()
        print("Hero name: \(hero.name)")
        print("Hero description: \(hero.description)")
        print("Hero photo URL: \(hero.photo)")
        print()
        print()
        print()
        
        heroNameLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        
        // Poner Imagen
        if let url = URL(string: hero.photo) {
            heroImageView.setImage(url: url)
        } else {
            heroImageView.image = nil
        }
    }
    
}


