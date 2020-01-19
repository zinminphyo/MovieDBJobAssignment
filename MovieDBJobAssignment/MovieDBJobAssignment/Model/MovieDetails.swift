//
//  MovieDetails.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation

struct Genres:Codable {
    let id :Int
    let name :String
    
}
struct SpokenLanguage:Codable {
    let iso_639_1 :String
    let name :String
}
struct Company :Codable {
    let id :Int?
    let logo_path :String?
    let name :String?
    let origin_country :String?
}

struct MovieDetails:Codable {
    
    let backdrop_path : String
    let genres : [Genres]
    let overview : String
    let popularity : Double
    let poster_path : String
    let vote_average : Double
    let title :String
    let release_date :String
    let spoken_languages :[SpokenLanguage]
    let production_companies : [Company]
    let homepage :String?
    
}


