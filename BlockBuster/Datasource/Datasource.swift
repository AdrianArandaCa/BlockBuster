//
//  Datasource.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation
import UIKit

enum DataSourceError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case apiKeyNotFound
    case invalidImage
}

protocol DatasourceProtocol {
    func getFilm(filmName: String, includeAdult: Bool) async throws -> FilmDataModel?
    func fetchPopularFilms() async throws -> FilmDataModel?
    func fetchImageFilm(imageURL: String) async throws -> UIImage
    func loadMoreFilms(nextPage: Int) async throws -> FilmDataModel?
}

final class Datasource: DatasourceProtocol {
    static let shared: Datasource = Datasource()
    
    enum URLInputs: String {
        case baseURL = "https://api.themoviedb.org/3"
        case popularURL = "/movie/popular?language=es-ES"
        case urlQuery = "/search/movie?query="
        case urlIncludeAdult = "&include_adult="
        case urlLanguage = "&language=es-ES"
        case baseImageURL = "https://image.tmdb.org/t/p/w500"
        case apiKey = "&api_key="
        case pageURL = "&page="
    }
    
    @MainActor
    func getFilm(filmName: String, includeAdult: Bool) async throws -> FilmDataModel? {
        do {
            let apikey = try getApiKey()
            guard let url = URL(string: String(format:"%@%@%@%@\(includeAdult)%@%@%@",
                                               URLInputs.baseURL.rawValue,
                                               URLInputs.urlQuery.rawValue,
                                               filmName,
                                               URLInputs.urlIncludeAdult.rawValue,
                                               URLInputs.urlLanguage.rawValue,
                                               URLInputs.apiKey.rawValue,
                                               apikey ))
            else { throw DataSourceError.invalidURL }
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw DataSourceError.invalidResponse }
                do {
                    let filmDataModel = try JSONDecoder().decode(FilmDataModel.self, from: data)
                    print("\(filmDataModel)")
                    return filmDataModel
                } catch {
                    throw DataSourceError.decodingError(error)
                }
            } catch {
                throw DataSourceError.networkError(error)
            }
        } catch let error {
            print(error.localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchPopularFilms() async throws -> FilmDataModel? {
        do {
            let apikey = try getApiKey()
            guard let url = URL(string: String(format:"%@%@%@%@",
                                               URLInputs.baseURL.rawValue,
                                               URLInputs.popularURL.rawValue,
                                               URLInputs.apiKey.rawValue,
                                               apikey))
            else { throw DataSourceError.invalidURL }
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw DataSourceError.invalidResponse }
                do {
                    let filmsDataModel = try JSONDecoder().decode(FilmDataModel.self, from: data)
                    print("\(filmsDataModel)")
                    return filmsDataModel
                } catch {
                    throw DataSourceError.networkError(error)
                }
            } catch {
                throw DataSourceError.decodingError(error)
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func loadMoreFilms(nextPage: Int) async throws -> FilmDataModel? {
        do {
            let apikey = try getApiKey()
            guard let url = URL(string: String(format:"%@%@%@%d%@%@",
                                               URLInputs.baseURL.rawValue,
                                               URLInputs.popularURL.rawValue,
                                               URLInputs.pageURL.rawValue,
                                               nextPage,
                                               URLInputs.apiKey.rawValue,
                                               apikey)) else { throw DataSourceError.invalidURL }
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw DataSourceError.invalidResponse }
                do {
                    let filmsDataModel = try JSONDecoder().decode(FilmDataModel.self, from: data)
                    print("\(filmsDataModel)")
                    return filmsDataModel
                } catch {
                    throw DataSourceError.networkError(error)
                }
            } catch {
                throw DataSourceError.decodingError(error)
            }
            
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    @MainActor
    func fetchImageFilm(imageURL: String) async throws -> UIImage {
        guard let url = URL(string:String(format:"%@%@",URLInputs.baseImageURL.rawValue, imageURL)) else {
            throw DataSourceError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw DataSourceError.invalidResponse }
            guard let image = UIImage(data: data) else { throw DataSourceError.invalidImage }
            return image
        } catch {
            throw DataSourceError.decodingError(error)
        }
    }
    
    func getApiKey() throws -> String {
        if let path = Bundle.main.path(forResource: "config", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any],
           let apiKey = config["API_KEY"] as? String {
            return apiKey
        } else {
            print("API Key not found")
            throw DataSourceError.apiKeyNotFound
        }
    }
}
