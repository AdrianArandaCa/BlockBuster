//
//  FetchPopularFilmsUseCase.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation

protocol FetchPopularFilmsProtocol {
//    func fetchPopularFilms () async throws -> [FilmModel]
    func fetchPopularFilms() async throws -> FilmDataModel?
    func loadMoreFilms(nextPage: Int) async throws -> FilmDataModel?
}

struct FetchPopularFilmsUseCase: FetchPopularFilmsProtocol {
    let datasource: DatasourceProtocol
    
    init(datasource: DatasourceProtocol = Datasource.shared) {
        self.datasource = datasource
    }
    
    func fetchPopularFilms() async throws -> FilmDataModel? {
        do {
            if let filmDataModel = try await datasource.fetchPopularFilms() {
                return filmDataModel
            }
        } catch {
            throw error
        }
        return nil
    }
    
    func loadMoreFilms(nextPage: Int) async throws -> FilmDataModel? {
        do {
            if let filmDataModel = try await datasource.loadMoreFilms(nextPage: nextPage) {
                return filmDataModel
            }
        } catch {
            throw error
        }
        return nil
    }
}
