//
//  FilmModelMapperTests.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import XCTest
@testable import BlockBuster

final class FilmModelMapperTests: XCTestCase {
    func testFilmModelMapper() {
        //Given
        let filmResult = mockFilmResult
        //When
        let film = FilmModelMapper.shared.mapFilmResponsesToModel(model: filmResult)
        //Then
        XCTAssertEqual(film.id, filmResult.id)
        XCTAssertEqual(film.title, filmResult.title)
        XCTAssertEqual(film.originalTitle, filmResult.originalTitle)
        XCTAssertEqual(film.isAdult, filmResult.adult)
        XCTAssertEqual(film.releaseDate, filmResult.releaseDate)
        XCTAssertEqual(film.backdrop, filmResult.backdropPath)
        XCTAssertEqual(film.voteAverage, filmResult.voteAverage)
        XCTAssertEqual(film.voteCount, filmResult.voteCount)
        XCTAssertEqual(film.overview, filmResult.overview)
        XCTAssertEqual(film.popularity, filmResult.popularity)
        XCTAssertEqual(film.poster, filmResult.posterPath)
    }
}
