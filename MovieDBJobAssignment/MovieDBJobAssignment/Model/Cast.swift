//
//  Cast.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 18/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation

struct CastInfo :Codable{
    let cast_id : Int?
    let character :String?
    let credit_id :String?
    let gender :Int?
    let id :Int?
    let name :String?
    let order :Int?
    let profile_path :String?
}

struct Cast :Codable {
    let id :Int?
    let cast :[CastInfo]?
}

struct CrewInfo :Codable{
    let credit_id :String?
    let department :String?
    let gender :Int?
    let id :Int?
    let job :String?
    let name :String?
    let profile_path :String?
}

struct Crew :Codable{
    let id :Int?
    let crew : [CrewInfo]?
}
