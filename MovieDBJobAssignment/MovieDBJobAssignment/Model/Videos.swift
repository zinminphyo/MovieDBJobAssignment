//
//  Videos.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 16/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation


struct VideoInfo :Codable {
    
    let id : String
    let key :String
    let name :String
    let site :String
    let size :Int
    let type :String
}

struct Videos :Codable {
    let id :Int?
    let results :[VideoInfo]?
    
}

