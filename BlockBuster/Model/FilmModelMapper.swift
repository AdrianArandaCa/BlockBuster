//
//  FilmModelMapper.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation
import UIKit

struct FilmModelMapper {
    static let shared = FilmModelMapper()
    func mapFilmResponsesToModel(model: FilmResult) -> FilmModel {
        return FilmModel.init(isAdult: model.adult, backdrop: model.backdropPath, id: model.id, originalTitle: model.originalTitle ?? "", overview: model.overview, popularity: model.popularity, poster: model.posterPath ?? "", releaseDate: model.releaseDate ?? "", title: model.title, voteAverage: model.voteAverage ?? 0.0, voteCount: model.voteCount ?? 0)
    }
}
