//
//  HerosListTableViewCell.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 11/03/25.
//

import UIKit

final class HerosListTableViewCell: UITableViewCell {
    @IBOutlet var heroNameLabel: UILabel!
    
    @IBOutlet var heroDescriptionLabel: UILabel!
    
    @IBOutlet var heroImageView: UIImageView!
    
    
    static let identifier = String(describing: HerosListTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // Recibir los Héroes y poner cada celda con los datos de cada uno
    func configureCellWithHero(with hero: Hero) {
        
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


