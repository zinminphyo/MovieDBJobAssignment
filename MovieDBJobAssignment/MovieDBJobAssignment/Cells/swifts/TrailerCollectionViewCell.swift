//
//  CastsCollectionViewCell.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 17/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class TrailerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trailerPlayerView: WKYTPlayerView!
    var videoInfo :VideoInfo? {
        didSet {
            if let videoInfo = videoInfo {
                let videoKey = videoInfo.key
                trailerPlayerView.load(withVideoId: videoKey)
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
