//
//  TransformationsDetailsViewController.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 19/03/25.
//

import UIKit

final class TransformationsDetailsViewController:
    UIViewController {
    var transformation: Transformation?
    static let identifier = String(describing: TransformationsDetailsViewController.self)
    
    @IBOutlet weak var imageDetails: UIImageView!
    
    @IBOutlet weak var nameDetails: UILabel!
    
    @IBOutlet weak var descriptionDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformation_Details_Configuration()
    }

    private func transformation_Details_Configuration() {
        nameDetails.text = transformation?.name
        descriptionDetails.text = transformation?.description
        
        if let url = URL(string: transformation?.photo ?? "") {
            imageDetails.setImage(url: url)
        }
        title = transformation?.name
    }

}
