//
//  TransformationsTableViewCell.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 14/03/25.
//

import UIKit

class TransformationsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TransformationsTableViewCell.self)

    @IBOutlet var transformationImageView: UIImageView!
    
    @IBOutlet var transformationNameLabel: UILabel!
    
    @IBOutlet var transformationDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureTransformationCell(with transformation: Transformation) {
        transformationNameLabel.text = transformation.name
        transformationDescriptionLabel.text = transformation.description
        if let url = URL(string: transformation.photo) {
            transformationImageView.setImage(url: url)
        }
    }
    
}
