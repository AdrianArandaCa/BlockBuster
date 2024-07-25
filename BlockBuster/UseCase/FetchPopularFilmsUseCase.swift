//
//  FetchPopularFilmsUseCase.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation

protocol FetchPopularFilmsProtocol {
    func fetchPopularFilms () async throws -> [FilmModel]
}

struct FetchPopularFilmsUseCase: FetchPopularFilmsProtocol {
    let datasource: DatasourceProtocol
    
    init(datasource: DatasourceProtocol = Datasource.shared) {
        self.datasource = datasource
    }
    
    func fetchPopularFilms () async throws -> [FilmModel] {
        do {
            if let popularFilmsSource = try await datasource.fetchPopularFilms() {
                return popularFilmsSource.results.map { FilmModelMapper.shared.mapFilmResponsesToModel(model: $0)}
            } else {
                return []
            }
        } catch let error {
            throw error
        }
    }
}
