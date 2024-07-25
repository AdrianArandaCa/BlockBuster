//
//  FilmResultModelTests.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import XCTest
@testable import BlockBuster

final class FilmResultModelTests: XCTestCase {
    func testFilmResultInitialization() {
        //Given
        let adult = true
        let backdropPath = "/hxSB02ksqnkXY4hPGAXqgO2fL01.jpg"
        let genreIDS = [12, 35, 878]
        let id = 105
        let originalLanguage = "en"
        let originalTitle = "Back to the Future"
        let overview = "Marty McFly, un estudiante de secundaria de 17 años, es enviado accidentalmente treinta años al pasado en un DeLorean que viaja en el tiempo, inventado por su gran amigo, el excéntrico científico Doc Brown."
        let popularity = 80.188
        let posterPath = "/owk40tn1sFJmC7bhamEpmhdZPKa.jpg"
        let releaseDate = "1985-07-03"
        let title = "Regreso al futuro"
        let video = false
        let voteAverage = 8.318
        let voteCount = 19514
        
        //When
        let filmResult = FilmResult.init(adult: adult, backdropPath: backdropPath, genreIDS: genreIDS, id: id, originalLanguage: originalLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount)
        
        //Then
        XCTAssertEqual(filmResult.adult, adult)
        XCTAssertEqual(filmResult.backdropPath, backdropPath)
        XCTAssertEqual(filmResult.genreIDS, genreIDS)
        XCTAssertEqual(filmResult.id, id)
        XCTAssertEqual(filmResult.originalLanguage, originalLanguage)
        XCTAssertEqual(filmResult.originalTitle, originalTitle)
        XCTAssertEqual(filmResult.overview, overview)
        XCTAssertEqual(filmResult.popularity, popularity)
        XCTAssertEqual(filmResult.posterPath, posterPath)
        XCTAssertEqual(filmResult.releaseDate, releaseDate)
        XCTAssertEqual(filmResult.title, title)
        XCTAssertEqual(filmResult.video, video)
        XCTAssertEqual(filmResult.voteAverage, voteAverage)
        XCTAssertEqual(filmResult.voteCount, voteCount)
    }

}
