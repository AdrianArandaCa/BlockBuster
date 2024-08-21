//
//  FilmIntegrationTest.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import XCTest
@testable import BlockBuster

final class FilmIntegrationTest: XCTestCase {
    
    var sut: FilmMain!
    
    @MainActor
    override func setUpWithError() throws {
        let datasource = Datasource.shared
        
        let getFilmUseCase = GetFilmUseCase(datasource: datasource)
        let fetchPopularFilmsUseCase = FetchPopularFilmsUseCase(datasource: datasource)
        let fetchFilmImageUseCase = FetchFilmImageUseCase(datasource: datasource)
        
        sut = FilmMain(fetchPopularFilmsUseCase: fetchPopularFilmsUseCase, fetchFilmImageUseCase: fetchFilmImageUseCase, getFilmUseCase: getFilmUseCase)
    }

    func testFetchPopularFilms() async throws {
        //Given
        
        //When
        do {
            let films = try await sut.fetchPopularFilmsUseCase.fetchPopularFilms()
            //Then
            XCTAssertNotNil(films)
        } catch let error {
            print("\(error.localizedDescription)")
            XCTFail()
        }
    }
    
    func testGetFilm() async throws {
        //Given
        let nameFilm = "Regreso al futuro"
        let isAdult = true
        //When
        do {
            let films = try await sut.getFilmUseCase.getFilm(name: nameFilm, isAdult: isAdult)
            let firstFilm = films.first
            //Then
            XCTAssertNotEqual(films.count, 0)
            XCTAssertEqual(firstFilm?.title, "Regreso al futuro")
        } catch let error {
            print("\(error.localizedDescription)")
            XCTFail()
        }
    }
    
    func testNotFoundFilm() async throws {
        //Given
        let nameFilm = "aaaaaaaaaaaa"
        let isAdult = false
        //When
        do {
            let films = try await sut.getFilmUseCase.getFilm(name: nameFilm, isAdult: isAdult)
            //Then
            print("Films = \(films)")
            XCTAssertEqual(films.count, 0)
        } catch let error {
            print("\(error.localizedDescription)")
            XCTFail()
        }
    }

    func testFetchFilmImage() async throws {
        //Given
        let url = "https://image.tmdb.org/t/p/w500/oTiQdzBOP5biNvzvrSPAvPxiSKH.jpg"
        //When
        do {
            let image = try await sut.fetchFilmImageUseCase.fetchFilmImage(url: url)
            //Then
            XCTAssertNotNil(image)
        } catch {
            print("\(error.localizedDescription)")
            XCTFail()
        }
    }
    
    func testLoadMoreFilms() async throws {
        //Given
        
        //When
        do {
            let film = try await sut.fetchPopularFilmsUseCase.loadMoreFilms(nextPage: 2)
            //Then
            XCTAssertEqual(film?.page, 2)
            XCTAssertNotNil(film)
        } catch {
            print("\(error.localizedDescription)")
            XCTFail()
        }
    }
}
