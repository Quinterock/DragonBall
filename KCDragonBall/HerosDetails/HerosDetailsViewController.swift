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
    
    @IBOutlet var heroImageDetail: UIImageView!
    
    @IBOutlet var heroNameDetail: UILabel!
    
    @IBOutlet var heroDescriptionDetail: UILabel!
    
    
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
