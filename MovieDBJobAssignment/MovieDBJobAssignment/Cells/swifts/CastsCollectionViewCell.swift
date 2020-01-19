//
//  MovieDetailCollectionViewCell.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit

class CastsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieDetailLayer: UIView!
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castCharacterLabel: UILabel!
    
    var castInfo : CastInfo? {
        didSet {
            if let castInfo = castInfo {
                guard let castImage = castInfo.profile_path else {return}
                NetWorkManager.getImageFromURL(castImage) { (castImage) in
                    self.castImageView.image = castImage
                }
                castNameLabel.text = castInfo.name
                castCharacterLabel.text = castInfo.character
            }
        }
    }
    
    var company : Company? {
        didSet {
            if let companyInfo = company {
                guard let companyLogo = companyInfo.logo_path else { return castImageView.image = UIImage(named: "NotFound") }
                NetWorkManager.getImageFromURL(companyLogo) { (companyImage) in
                    self.castImageView.image = companyImage
                }
                castNameLabel.text = companyInfo.name
                castCharacterLabel.text = companyInfo.origin_country

            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieDetailLayer.layer.cornerRadius = 10
        movieDetailLayer.layer.masksToBounds = true
        movieDetailLayer.layer.borderColor = UIColor.gray.cgColor
        movieDetailLayer.layer.borderWidth = 0.3
    }

}
