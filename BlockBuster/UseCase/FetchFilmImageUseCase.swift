//
//  FetchFilmImageUseCase.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 31/7/24.
//

import Foundation
import UIKit

protocol FetchFilmImageProtocol {
    func fetchFilmImage(url: String) async throws -> UIImage
}

class FetchFilmImageUseCase: FetchFilmImageProtocol {
    var datasource: DatasourceProtocol
    
    init(datasource: DatasourceProtocol = Datasource.shared) {
        self.datasource = datasource
    }
    
    func fetchFilmImage(url: String) async throws -> UIImage {
        return try await datasource.fetchImageFilm(imageURL: url)
    }
}
