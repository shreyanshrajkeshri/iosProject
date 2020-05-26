//
//  HomeModule.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import Foundation

let TMDBApiKey = "7b3f0b08ae42d8a4b702665de755b051"


struct Trending: Codable {
    
    let posterImage: String
    let mediaType: String
    let posterPath: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "backdrop_path"
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case rating = "vote_average"
        
    }
    
}

struct TrendingResults: Decodable {
    
    var page: Int
    var results: [Trending]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
    
}




struct Movies: Codable {
    
    let posterImage: String
    let title: String
    let rating: Double
    let movieImage: String
    let description: String
    let releaseDate: String
    
    init() {
        posterImage = ""
        title = ""
        rating = 0.0
        movieImage = ""
        description = ""
        releaseDate = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "backdrop_path"
        case title
        case rating = "vote_average"
        case movieImage = "poster_path"
        case description = "overview"
        case releaseDate = "release_date"
    }
}


struct MoviesResults: Decodable {
    
    var page: Int
    var results: [Movies]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
}

