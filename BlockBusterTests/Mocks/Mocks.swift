//
//  Mocks.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation
import UIKit
@testable import BlockBuster

let mockFilmResult = FilmResult.init(adult: true,
                                     backdropPath: "/hxSB02ksqnkXY4hPGAXqgO2fL01.jpg",
                                     genreIDS: [12, 35, 878],
                                     id: 105,
                                     originalLanguage: "en",
                                     originalTitle: "Back to the Future",
                                     overview: "Marty McFly, un estudiante de secundaria de 17 años, es enviado accidentalmente treinta años al pasado en un DeLorean que viaja en el tiempo, inventado por su gran amigo, el excéntrico científico Doc Brown.",
                                     popularity: 80.188,
                                     posterPath: "/owk40tn1sFJmC7bhamEpmhdZPKa.jpg",
                                     releaseDate: "1985-07-03",
                                     title: "Regreso al futuro", 
                                     video: false,
                                     voteAverage: 8.318,
                                     voteCount: 19514)

let mockFilmModel = FilmModel.init(isAdult: false,
                                   backdrop: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg",
                                   id: 1022789,
                                   originalTitle: "Inside Out 2",
                                   overview: "Riley, ahora siendo una adolescente, se enfrenta a una reforma en la Central de sus emociones. Alegría, Tristeza, Furia, Miedo y Asco deben adaptarse a la llegada de nuevas emociones: Ansiedad, Vergüenza, Envidia, Ennui y Nostalgia\r ¿Cómo manejarán este inesperado cambio?",
                                   popularity: 4599.773,
                                   poster: "/aQnbNiadeGzGSjWLaXyeNxpAUIx.jpg",
                                   releaseDate: "2024-06-11",
                                   title: "Del revés 2 (Inside Out 2)",
                                   voteAverage: 7.648,
                                   voteCount: 2052)

var mockDatasource: [FilmModel] = []

struct FetchPopularFilmsUseCaseMock: FetchPopularFilmsProtocol {
    func fetchPopularFilms() async throws -> BlockBuster.FilmDataModel? {
        let filmDataModel = FilmDataModel(page: 1, results: [mockFilmResult], totalPages: 5, totalResults: 50)
        return filmDataModel
    }
    
    func loadMoreFilms(nextPage: Int) async throws -> BlockBuster.FilmDataModel? {
        let filmDataModel = FilmDataModel(page: 1, results: [mockFilmResult], totalPages: 1, totalResults: 1)
        return filmDataModel
    }
    
    func fetchPopularFilms() async throws -> [BlockBuster.FilmModel] {
        let films = [
            FilmModel.init(isAdult: false, 
                           backdrop: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg",
                           id: 1022789,
                           originalTitle: "Inside Out 2",
                           overview: "Riley, ahora siendo una adolescente, se enfrenta a una reforma en la Central de sus emociones. Alegría, Tristeza, Furia, Miedo y Asco deben adaptarse a la llegada de nuevas emociones: Ansiedad, Vergüenza, Envidia, Ennui y Nostalgia\r ¿Cómo manejarán este inesperado cambio?",
                           popularity: 4599.773,
                           poster: "/aQnbNiadeGzGSjWLaXyeNxpAUIx.jpg",
                           releaseDate: "2024-06-11",
                           title: "Del revés 2 (Inside Out 2)",
                           voteAverage: 7.648,
                           voteCount: 2052),
            FilmModel.init(isAdult: false, 
                           backdrop: "/fDmci71SMkfZM8RnCuXJVDPaSdE.jpg",
                           id: 519182,
                           originalTitle: "Despicable Me 4",
                           overview: "Gru, Lucy y las niñas -Margo, Edith y Agnes- dan la bienvenida a un nuevo miembro en la familia: Gru Junior, que parece llegar con el propósito de ser un suplicio para su padre. Gru tendrá que enfrentarse en esta ocasión a su nueva némesis Maxime Le Mal y su sofisticada y malévola novia Valentina, lo que obligará a la familia a tener que darse a la fuga. Cuarta entrega de 'Gru, mi villano favorito'.",
                           popularity: 3483.085,
                           poster: "/wTpzSDfbUuHPEgqgt5vwVtPHhrb.jpg",
                           releaseDate: "2024-06-20",
                           title: "Gru 4. Mi villano favorito",
                           voteAverage: 7.214,
                           voteCount: 395),
            FilmModel.init(isAdult: false,
                           backdrop: "/Akv9GlCCMrzcDkVz4ad8MdLl9DK.jpg",
                           id: 748783,
                           originalTitle: "The Garfield Movie",
                           overview: "El mundialmente famoso Garfield, el gato casero que odia los lunes y que adora la lasaña, está a punto de vivir una aventura ¡en el salvaje mundo exterior! Tras una inesperada reunión con su largamente perdido padre – el desaliñado gato callejero Vic – Garfield y su amigo canino Odie se ven forzados a abandonar sus perfectas y consentidas vidas al unirse a Vic en un hilarante y muy arriesgado atraco.",
                           popularity: 1624.079,
                           poster: "/tkdc73JiPVvzngSpbLEIfFNjll1.jpg",
                           releaseDate: "2024-04-30",
                           title: "Garfield: La película",
                           voteAverage: 7.258,
                           voteCount: 555),
            FilmModel.init(isAdult: false,
                            backdrop: "/dvBCdCohwWbsP5qAaglOXagDMtk.jpg",
                            id: 533535,
                            originalTitle: "Deadpool & Wolverine",
                            overview: "Tercera entrega de la saga \"Deadpool\".",
                            popularity: 1556.425,
                            poster: "/9TFSqghEHrlBMRR63yTx80Orxva.jpg",
                            releaseDate: "2024-07-24",
                            title: "Deadpool y Lobezno",
                            voteAverage: 8.096,
                            voteCount: 109)
        ]
        mockDatasource.append(contentsOf: films)
        return mockDatasource
    }
}

struct GetFilmUseCaseMock : GetFilmProtocol {
    func getFilm(name: String, isAdult: Bool) async throws -> [BlockBuster.FilmModel] {
        let films = [
            FilmModel.init(isAdult: false,
                           backdrop: "/hxSB02ksqnkXY4hPGAXqgO2fL01.jpg",
                           id: 105,
                           originalTitle: "Back to the Future",
                           overview: "Marty McFly, un estudiante de secundaria de 17 años, es enviado accidentalmente treinta años al pasado en un DeLorean que viaja en el tiempo, inventado por su gran amigo, el excéntrico científico Doc Brown.",
                           popularity: 80.188,
                           poster: "/owk40tn1sFJmC7bhamEpmhdZPKa.jpg",
                           releaseDate: "1985-07-03",
                           title: "Regreso al futuro",
                           voteAverage: 8.318,
                           voteCount: 19514),
            FilmModel.init(isAdult: false,
                           backdrop: "/skQN2UMQKQnOTmwplcYMx6ZF4jS.jpg",
                           id: 165,
                           originalTitle: "Back to the Future Part II",
                           overview: "Marty y Doc vuelven a hacerlo en esta alocada secuela del éxito de taquilla de 1985, ya que el dúo de viajeros en el tiempo se dirige al 2015 para cortar de raíz algunos problemas de la familia McFly. Pero las cosas salen mal gracias al matón Biff Tannen y un molesto almanaque deportivo. En un último intento por aclarar las cosas, Marty se encuentra con destino a 1955 y cara a cara con sus padres adolescentes, nuevamente.",
                           popularity: 83.158,
                           poster: "/oTiQdzBOP5biNvzvrSPAvPxiSKH.jpg",
                           releaseDate: "1989-11-22",
                           title: "Regreso al futuro: Parte II",
                           voteAverage: 7.762,
                           voteCount: 12504),
            FilmModel.init(isAdult: false,
                           backdrop: "/vKp3NvqBkcjHkCHSGi6EbcP7g4J.jpg",
                           id: 196,
                           originalTitle: "Back to the Future Part III",
                           overview: "Atrapado en 1955, Marty McFly se entera de la muerte de Doc Brown en 1885 y debe viajar en el tiempo para salvarlo. Sin combustible para el DeLorean, los dos deben averiguar cómo escapar del viejo Oeste antes de que Emmett sea asesinado.",
                           popularity: 49.696,
                           poster: "/c7vYpsBMKZ3AwhBlc7wwGGMPlRA.jpg",
                           releaseDate: "1990-05-25",
                           title: "Regreso al futuro: Parte III",
                           voteAverage: 7.475,
                           voteCount: 10262)
        ]
        mockDatasource.append(contentsOf: films)
        return mockDatasource
    }
}

struct FetchFilmImageCaseMock: FetchFilmImageProtocol {
    var mockImage: UIImage?
    var mockError: Error?
    
    func fetchFilmImage(url: String) async throws -> UIImage {
        if let error = mockError {
            throw error
        }
        if let image = mockImage {
            return image
        }
        throw DataSourceError.invalidImage
    }
}
