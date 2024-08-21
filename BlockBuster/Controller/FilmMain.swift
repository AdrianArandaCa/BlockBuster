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
        setStyle()
        fillData()
        if let items = tabBar.items {
                    for item in items {
                        item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
                        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
                    }
                }
    }
    
    func setStyle() {
        tabBar.itemPositioning = .centered
        if let tabBarItems = self.tabBar.items {
            let homeItem = tabBarItems[0]
            homeItem.image = UIImage(systemName: "house")
            homeItem.title = "HOME".localizable
            
            let searchItem = tabBarItems[1]
            searchItem.image = UIImage(systemName: "magnifyingglass")
            searchItem.title = "SEARCH".localizable
        }
        
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = ColorStyle.unselectedItem.color()
        self.tabBar.itemPositioning = .centered
    }
    
    func initChilds() {
        if let secondVC = viewControllers?[0] as? FilmCollectionViewVC {
            filmCollectionViewVC = secondVC
            filmCollectionViewVC?.delegate = self
        }
        if let firstVC = viewControllers?[1] as? FilmSearchVC {
            filmSearchVC = firstVC
            filmSearchVC?.delegate = self
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
        guard name != "", let filmSearchVC = filmSearchVC/*, let filmCollectionViewVC = filmCollectionViewVC*/ else { return }
        Task {
            do {
                var films = try await getFilmUseCase.getFilm(name: name, isAdult: true)
                for (index, film) in films.enumerated() {
                    films[index].image = try await getImage(film: film)
                }
                self.selectedViewController = filmSearchVC
                filmSearchVC.configure(films: films, kindList: .search)
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
    
    func loadMoreData(kindList: FilmKindList) {
        guard let filmCollectionViewVC = filmCollectionViewVC, let filmData = self.filmData else { return }
        isLoading = true
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
                        filmCollectionViewVC.addMoreData(films: films, kindList: kindList)
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
