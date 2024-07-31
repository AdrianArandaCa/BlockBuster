//
//  FilmModel.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation
import UIKit

struct FilmModel {
    let isAdult: Bool
    let backdrop: String?
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let poster: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    var image: UIImage?
    
    static var empty: Self {
        .init(isAdult: false, backdrop: "", id: 0, originalTitle: "", overview: "", popularity: 0.0, poster: "", releaseDate: "", title: "", voteAverage: 0.0, voteCount: 0, image: nil)
    }
}
