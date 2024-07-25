//
//  GetFilmUseCase.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation

protocol GetFilmProtocol {
    func getFilm(name: String, isAdult: Bool) async throws -> [FilmModel]
}

struct GetFilmUseCase: GetFilmProtocol {
    var datasource: DatasourceProtocol
    
    init(datasource: DatasourceProtocol = Datasource.shared) {
        self.datasource = datasource
    }
    
    func getFilm(name: String, isAdult: Bool) async throws -> [FilmModel] {
        do {
            if let filmDataSource = try await datasource.getFilm(filmName: name, includeAdult: isAdult) {
                return filmDataSource.results.map { FilmModelMapper.shared.mapFilmResponsesToModel(model: $0) }
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
}
