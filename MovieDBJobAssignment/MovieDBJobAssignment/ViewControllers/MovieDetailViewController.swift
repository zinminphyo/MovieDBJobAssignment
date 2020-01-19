//
//  MovieDetailViewController.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailCollectionView: UICollectionView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDirectorName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var synophisButton: UIButton!
    @IBOutlet weak var castButton: UIButton!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var pictureButton: UIButton!
    
    var castsOfMovie :Cast?
    var movieDetailResult : MovieDetails?
    var videosOfMovie : Videos?
    var crewsOfMovie :Crew?
    var movieID : Int?
    var tabName :String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        movieDetailCollectionView.dataSource = self
        movieDetailCollectionView.delegate = self
        
        //View SetUp
        navigationBarConfigure()
        movieDetailImage.addOverlay()
        
        //Get MovieDetails
        NetWorkManager.getMovieDetails(movieID!) {
            self.movieDetailResult = NetWorkManager.movieDetails
            NetWorkManager.getImageFromURL(self.movieDetailResult!.backdrop_path) { (movieBackDropImage) in
                self.movieDetailImage.image = movieBackDropImage
            }
            self.movieDescription.text = self.movieDetailResult!.overview
            self.movieName.text = self.movieDetailResult?.title
            
            self.movieType.text = ""
            for genre in self.movieDetailResult!.genres {
                self.movieType.text?.append(contentsOf: "\(genre.name)|")
            }
            guard let movieRating = self.movieDetailResult?.vote_average else {return print("Can't get vote average.")}
            self.movieRating.text = String(describing: movieRating)
        }
        
        //Get MovieCasts
        NetWorkManager.getCasts(movieID!) {
            self.castsOfMovie = NetWorkManager.casts
        }
        
        //Get MovieCrews
        NetWorkManager.getCrews(movieID!) {
            self.crewsOfMovie = NetWorkManager.crews
            for crew in (self.crewsOfMovie?.crew)! {
                if crew.job == "Director of Photography" {
                    self.movieDirectorName.text = crew.name
                }
            }
        }
            
        //Get Videos
        NetWorkManager.getVideos(movieID!) {
            self.videosOfMovie = NetWorkManager.videos
            
        }
        
        //Registering collectionview cells
        movieDetailCollectionView.register(UINib(nibName: String(describing: CastsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CastsCollectionViewCell.self))
        movieDetailCollectionView.register(UINib(nibName: String(describing: TrailerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TrailerCollectionViewCell.self))
        movieDetailCollectionView.register(UINib(nibName: String(describing: SynopsisCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SynopsisCollectionViewCell.self))
    }
    
    //IBAction
    @IBAction func didTapSynopsis(_ sender: UIButton) {
        tabName = TabName.Synopsis.rawValue
        movieDetailCollectionView.reloadData()
        resetButtonCondition()
        sender.setTitleColor(.black, for: .normal)
    }
    @IBAction func didTapCastButton(_ sender: UIButton) {
        tabName = TabName.Cast.rawValue
        resetButtonCondition()
        sender.setTitleColor(.black, for: .normal)
        movieDetailCollectionView.reloadData()
    }
    @IBAction func didTapTrailerButton(_ sender: UIButton) {
        tabName = TabName.Trailer.rawValue
        resetButtonCondition()
        sender.setTitleColor(.black, for: .normal)
        movieDetailCollectionView.reloadData()
    }
    @IBAction func didTapPictureButton(_ sender: UIButton) {
        tabName = TabName.Picture.rawValue
        resetButtonCondition()
        sender.setTitleColor(.black, for: .normal)
        self.movieDetailCollectionView.reloadData()
    }
    
    func resetButtonCondition(){
        synophisButton.setTitleColor(.gray, for: .normal)
        castButton.setTitleColor(.gray, for: .normal)
        trailerButton.setTitleColor(.gray, for: .normal)
        pictureButton.setTitleColor(.gray, for: .normal)
    }
    
    func navigationBarConfigure(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
}

//UICollection View Data Source
extension MovieDetailViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tabName {
        case "Synopsis":
            return 1
            
        case "Cast" :
            return castsOfMovie?.cast?.count ?? 0
            
        case "Trailer" :
            return videosOfMovie?.results?.count ?? 0
            
        case "Picture" :
            return movieDetailResult?.production_companies.count ?? 0
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch tabName {

        case "Synopsis":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SynopsisCollectionViewCell.self), for: indexPath) as? SynopsisCollectionViewCell else { return UICollectionViewCell() }
            cell.movieDetail = movieDetailResult
            return cell

        case "Cast":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastsCollectionViewCell.self), for: indexPath) as? CastsCollectionViewCell else { return UICollectionViewCell() }
            cell.castInfo = castsOfMovie?.cast?[indexPath.row]
            return cell
            
        case "Trailer" :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrailerCollectionViewCell.self), for: indexPath) as? TrailerCollectionViewCell else { return UICollectionViewCell() }
            cell.videoInfo = videosOfMovie?.results?[indexPath.row]
            return cell
            
        case "Picture" :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastsCollectionViewCell.self), for: indexPath) as? CastsCollectionViewCell else { return UICollectionViewCell() }
            cell.company = movieDetailResult?.production_companies[indexPath.row]
            return cell

        default : return UICollectionViewCell()

        }
    }
    
}

//UICollection View Delegate
extension MovieDetailViewController :UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch tabName {

        case "Synopsis" :
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 273)
            
        case "Cast" :
            return CGSize(width: 150, height: 230)
            
        case "Trailer" :
            return CGSize(width: UIScreen.main.bounds.width - 90, height: 230)
            
        default :
            return CGSize(width: 150, height: 230)

        }
    }
        
}

