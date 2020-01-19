//
//  Movie.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation


struct MovieInfo :Codable {
    let id : Int
    let poster_path : String
    let title : String
    
    init(id:Int,title:String,posterPath:String) {
        self.id = id
        self.title = title
        self.poster_path = posterPath
    }
}
struct MovieResults : Codable {
    let page : Int
    let total_results : Int
    let total_pages : Int
    var results : [MovieInfo]
    
}
