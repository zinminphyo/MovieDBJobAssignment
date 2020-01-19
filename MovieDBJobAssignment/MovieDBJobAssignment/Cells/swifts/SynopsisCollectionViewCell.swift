//
//  SynopsisCollectionViewCell.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 17/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit

class SynopsisCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var subtitlesLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!
    
    var movieDetail : MovieDetails?  {
        didSet {
            if let detail = movieDetail {
                releaseDateLabel.text = detail.release_date
                languageLabel.text = detail.spoken_languages[0].name
                subtitlesLabel.text = detail.spoken_languages[0].name
                storyLabel.text = detail.overview
            }
        }
    }
    
    @IBAction func didTapOfficialPageButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: (movieDetail?.homepage)!)!, options: .init(), completionHandler: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

}


