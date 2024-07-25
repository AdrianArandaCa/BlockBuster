//
//  FilmModelTest.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import XCTest
@testable import BlockBuster

final class FilmModelTests: XCTestCase {
    func testFilmInitialization() {
        //Given
        let isAdult = true
        let backdrop = "/hxSB02ksqnkXY4hPGAXqgO2fL01.jpg"
        let id = 105
        let originalTitle = "Back to the Future"
        let overview = "Marty McFly, un estudiante de secundaria de 17 años, es enviado accidentalmente treinta años al pasado en un DeLorean que viaja en el tiempo, inventado por su gran amigo, el excéntrico científico Doc Brown."
        let popularity = 80.188
        let poster = "/owk40tn1sFJmC7bhamEpmhdZPKa.jpg"
        let releaseDate = "1985-07-03"
        let title = "Regreso al futuro"
        let voteAverage = 8.318
        let voteCount = 19514
        
        //When
        let testFilm = FilmModel.init(isAdult: isAdult, backdrop: backdrop, id: id, originalTitle: originalTitle, overview: overview, popularity: popularity, poster: poster, releaseDate: releaseDate, title: title, voteAverage: voteAverage, voteCount: voteCount)
        
        XCTAssertEqual(testFilm.isAdult, isAdult)
        XCTAssertEqual(testFilm.backdrop, backdrop)
        XCTAssertEqual(testFilm.id, id)
        XCTAssertEqual(testFilm.originalTitle, originalTitle)
        XCTAssertEqual(testFilm.overview, overview)
        XCTAssertEqual(testFilm.popularity, popularity)
        XCTAssertEqual(testFilm.poster, poster)
        XCTAssertEqual(testFilm.releaseDate, releaseDate)
        XCTAssertEqual(testFilm.title, title)
        XCTAssertEqual(testFilm.voteAverage, voteAverage)
        XCTAssertEqual(testFilm.voteCount, voteCount)
    }
}
