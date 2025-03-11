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
    
    
    
    static let identifier = String(describing: HerosListTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
