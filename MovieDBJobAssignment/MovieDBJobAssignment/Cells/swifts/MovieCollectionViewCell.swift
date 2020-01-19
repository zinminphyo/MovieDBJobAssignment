//
//  MovieCollectionViewCell.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 15/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10
        movieImage.layer.masksToBounds = true
    }

}
