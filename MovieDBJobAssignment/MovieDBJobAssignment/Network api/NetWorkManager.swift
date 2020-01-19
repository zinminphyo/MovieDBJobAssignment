//
//  NetWorkManager.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation
import UIKit


class NetWorkManager {
    
    static var results : MovieResults?
    static var movieDetails : MovieDetails?
    static var videos : Videos?
    static var casts : Cast?
    static var crews : Crew?
    
    static func downloadJSON(_ baseURL:String, completed: @escaping () -> () )
    {
        guard let url = URL(string: baseURL+Constants.API_KEY) else {return print("Error unwrapping url.")}
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let unwrappedData = data else {return print("Error unwrapping data.")}
                do{
                    NetWorkManager.results = try JSONDecoder().decode(MovieResults.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("\(error) ,\(error.localizedDescription)")
                }
            }
            
        }
        dataTask.resume()
    }
        
    static func getImageFromURL(_ urlString: String, closure: @escaping (UIImage?) -> ()){
        guard let url = URL(string: Constants.IMAGE_BASE_URL+urlString) else { return print("Error unwrapping image url.") }
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let unwrappedData = data else {return print("Error unwrapping image data.")}
                DispatchQueue.main.async {
                    closure(UIImage(data: unwrappedData))
                }
            }
        }
        dataTask.resume()
    }
    
    static func getMovieDetails(_ movieId :Int,completed: @escaping () -> ()) {
        guard let unwrappedURL = URL(string: "\(Constants.MOVIE_DETAIL_API)\(movieId)?api_key=\(Constants.API_KEY)") else {return print("Error unwrapping movie detail url.")}
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: unwrappedURL) { (data, response, error) in
            if error == nil {
                guard let unwrappedData = data else  { return print("Error unwrapping data.") }
                do {
                    NetWorkManager.movieDetails = try JSONDecoder().decode(MovieDetails.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch  {
                    print("\(error) ,\(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
    
    static func getVideos(_ movieID : Int ,completed: @escaping () -> ()){
        guard let unwrappedURL = URL(string: "\(Constants.MOVIE_DETAIL_API)\(movieID)/videos?api_key=\(Constants.API_KEY)") else {return print("Error unwrapping movie vidoes url.")}
        print("Videos url is \(unwrappedURL)")
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: unwrappedURL) { (data, reponse, error) in
            if error == nil {
                guard let unwrappedData = data else {return print("Error unwrapping movie videos data.")}
                do {
                    NetWorkManager.videos = try JSONDecoder().decode(Videos.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch  {
                    print("\(error) ,\(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
    
    static func getCasts(_ movieID :Int ,completed: @escaping () -> ()) {
        guard let unwrappedURL = URL(string: "\(Constants.MOVIE_DETAIL_API)\(movieID)/credits?api_key=\(Constants.API_KEY)") else { return print("Error unwrapping credits url.") }
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: unwrappedURL) { (data, response, error) in
            if error == nil {
                guard let unwrappedData = data else {return print("Error unwrapping casts data.")}
                do {
                    NetWorkManager.casts = try JSONDecoder().decode(Cast.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch  {
                    print("\(error) ,\(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
    
    static func getCrews(_ movieID :Int ,completed: @escaping () -> ()){
        guard let unwrappedURL = URL(string: "\(Constants.MOVIE_DETAIL_API)\(movieID)/credits?api_key=\(Constants.API_KEY)") else { return print("Error unwrapping crews url.") }
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: unwrappedURL) { (data, response, error) in
            if error == nil {
                guard let unwrappedData = data else { return print("Error unwrapping crews data.") }
                do {
                    NetWorkManager.crews = try JSONDecoder().decode(Crew.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch  {
                    print("\(error) ,\(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
        
    }
    
    
}
