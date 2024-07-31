//
//  FilmMain.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import UIKit

class FilmMain: UITabBarController {
    
    var fetchPopularFilmsUseCase: FetchPopularFilmsProtocol
    var fetchFilmImageUseCase:FetchFilmImageProtocol
    var getFilmUseCase: GetFilmProtocol
    
    var filmCollectionViewVC: FilmCollectionViewVC?
    var filmTableViewVC: FilmTableViewVC?
    var filmSearchVC: FilmSearchVC?
    
    var filmData: FilmDataModel?
    var isLoading = false
    
    init(fetchPopularFilmsUseCase: FetchPopularFilmsProtocol = FetchPopularFilmsUseCase(),
         fetchFilmImageUseCase: FetchFilmImageProtocol = FetchFilmImageUseCase(),
         getFilmUseCase: GetFilmProtocol = GetFilmUseCase()) {
        self.fetchPopularFilmsUseCase = fetchPopularFilmsUseCase
        self.fetchFilmImageUseCase = fetchFilmImageUseCase
        self.getFilmUseCase = getFilmUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.fetchPopularFilmsUseCase = FetchPopularFilmsUseCase()
        self.fetchFilmImageUseCase = FetchFilmImageUseCase()
        self.getFilmUseCase = GetFilmUseCase()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initChilds()
        fillData()
    }
    
    func initChilds() {
        if let firstVC = viewControllers?[0] as? FilmSearchVC {
            filmSearchVC = firstVC
            filmSearchVC?.delegate = self
        }
        if let secondVC = viewControllers?[1] as? FilmCollectionViewVC {
            filmCollectionViewVC = secondVC
            filmCollectionViewVC?.delegate = self
//            filmTableViewVC = secondVC
//            filmTableViewVC?.delegate = self
        }
    }
    
    @MainActor
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @MainActor
    func fillData() {
        guard let filmCollectionViewVC = filmCollectionViewVC else { return }
        Task {
            do {
                filmData = try await self.fetchPopularFilmsUseCase.fetchPopularFilms()
                if let filmData = filmData {
                    var films = mapperFilms(filmDataModel: filmData)
                    for (index, film) in films.enumerated() {
                        films[index].image = try await getImage(film: film)
                    }
                    filmCollectionViewVC.configure(films: films, kindList: .popular)
                    //                filmTableViewVC.configure(films: films)
                }

            } catch {
                showError(error: error)
            }
        }
    }
    
    func mapperFilms(filmDataModel: FilmDataModel) -> [FilmModel]{
        return filmDataModel.results.map { FilmModelMapper.shared.mapFilmResponsesToModel(model: $0)}
    }
    
    func getImage(film: FilmModel) async throws -> UIImage {
        do {
            return try await fetchFilmImageUseCase.fetchFilmImage(url: film.poster)
        } catch let error {
            throw error
        }
    }
}

extension FilmMain: FilmSearchDelegate {
    func searchFilm(name: String) {
        guard name != "", let filmCollectionViewVC = filmCollectionViewVC else { return }
        Task {
            do {
                var films = try await getFilmUseCase.getFilm(name: name, isAdult: true)
                for (index, film) in films.enumerated() {
                    films[index].image = try await getImage(film: film)
                }
                self.selectedViewController = filmCollectionViewVC
                filmCollectionViewVC.configure(films: films, kindList: .search)
//                self.selectedViewController = filmTableViewVC
//                filmTableViewVC.configure(films: films)
            } catch {
                showError(error: error)
            }
        }
    }
}

extension FilmMain: FilmCollectionViewDelegate {
    func filmPressed() {
        
    }
    
    func loadMoreData() {
        isLoading = true
        guard let filmCollectionViewVC = filmCollectionViewVC, let filmData = self.filmData else { return }
        Task {
            do {
                let nextPage = filmData.page + 1
                if filmData.totalPages > nextPage {
                    if let moreFilmData = try await self.fetchPopularFilmsUseCase.loadMoreFilms(nextPage: nextPage) {
                        var films = mapperFilms(filmDataModel: moreFilmData)
                        for (index, film) in films.enumerated() {
                            films[index].image = try await getImage(film: film)
                        }
                        self.filmData = moreFilmData
                        filmCollectionViewVC.addMoreData(films: films, kindList: .popular)
                        isLoading = false
                    } else {
                        return
                    }
                } else {
                    return
                }
                
                

            } catch {
                showError(error: error)
            }
        }
    }
}
