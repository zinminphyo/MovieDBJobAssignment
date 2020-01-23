//
//  ViewController.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 15/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import Kingfisher

class HomeViewController: UIViewController {

    
    //IBOutlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var trendingBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var upcomingBarButtonItem: UIBarButtonItem!
    var list_of_movies : MovieResults?
    

    //IBActions
    @IBAction func didTapTrendingBArButtonItem(_ sender: UIBarButtonItem) {
        trendingBarButtonItem.tintColor = UIColor(named: "textColor")
        upcomingBarButtonItem.tintColor = .darkGray
        NetWorkManager.downloadJSON(Constants.TRENDING_BASE_URL) {
            self.list_of_movies = NetWorkManager.results
            self.moviesCollectionView.reloadData()
        }
    }
    
    @IBAction func didTapUpComingBarButtonItem(_ sender: UIBarButtonItem) {
        trendingBarButtonItem.tintColor = .darkGray
        upcomingBarButtonItem.tintColor = UIColor(named: "textColor")
        NetWorkManager.downloadJSON(Constants.UPCOMING_BASE_URL) {
            self.list_of_movies = NetWorkManager.results
            self.moviesCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        trendingBarButtonItem.tintColor = UIColor(named: "textColor")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        self.list_of_movies?.results.removeAll()
        NetWorkManager.downloadJSON(Constants.TRENDING_BASE_URL) {
            self.list_of_movies = NetWorkManager.results
            self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
        }
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
        upcomingBarButtonItem.tintColor = .darkGray
        
    }
    
}

//UICollectionView DataSource
extension HomeViewController :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = self.list_of_movies?.results.count else {  return 0  }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        if let currentMovie = list_of_movies?.results[indexPath.row]{
            cell.movieName.text = currentMovie.title
            let posterPath = currentMovie.poster_path
            let imageURL = URL(string: Constants.IMAGE_BASE_URL+posterPath)
            cell.movieImage.kf.setImage(with:imageURL)
        }
        return cell
    }
}

//UICollectionView Delegate Flow Layout
extension HomeViewController :UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: 150, height: 300)
    }
}

//UICollection Delegate
extension HomeViewController :UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {return print("No destination view controller is found.")}
        destinationViewController.movieID = list_of_movies?.results[indexPath.row].id
        navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}

