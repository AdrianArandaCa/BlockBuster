//
//  FilmMain.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import UIKit

class FilmMain: UITabBarController {
    
    var fetchPopularFilmsUseCase: FetchPopularFilmsProtocol
    var getFilmUseCase: GetFilmProtocol
    
    var filmTableViewVC: FilmTableViewVC?
    var filmSearchVC: FilmSearchVC?
    
    init(fetchPopularFilmsUseCase: FetchPopularFilmsProtocol = FetchPopularFilmsUseCase(),
         getFilmUseCase: GetFilmProtocol = GetFilmUseCase()) {
        self.fetchPopularFilmsUseCase = fetchPopularFilmsUseCase
        self.getFilmUseCase = getFilmUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.fetchPopularFilmsUseCase = FetchPopularFilmsUseCase()
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
        if let secondVC = viewControllers?[1] as? FilmTableViewVC {
            filmTableViewVC = secondVC
            filmTableViewVC?.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilmTableViewVC {
            filmTableViewVC = vc
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
        guard let filmTableViewVC = filmTableViewVC else { return }
        Task {
            do {
                let films = try await fetchPopularFilmsUseCase.fetchPopularFilms()
                filmTableViewVC.configure(films: films)
            } catch {
                showError(error: error)
            }
        }
    }
}

extension FilmMain: FilmSearchDelegate {
    func searchFilm(name: String) {
        guard name != "", let filmTableViewVC = filmTableViewVC else { return }
        Task {
            do {
                let films = try await getFilmUseCase.getFilm(name: name, isAdult: true)
                self.selectedViewController = filmTableViewVC
                filmTableViewVC.configure(films: films)
            } catch {
                showError(error: error)
            }
        }
    }
}

extension FilmMain: FilmTableViewDelegate {
    func filmPressed() {
        
    }
}
