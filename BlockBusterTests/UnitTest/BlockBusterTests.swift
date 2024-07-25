//
//  BlockBusterTests.swift
//  BlockBusterTests
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import XCTest
@testable import BlockBuster

final class BlockBusterTests: XCTestCase {
    
    var dataSource: Datasource!
    
    override func setUpWithError() throws {
         dataSource = Datasource()
    }

    func testGetApiKey() {
        //Given
        do {
            //When
            let apiKey = try dataSource.getApiKey()
            //Then
            XCTAssertNotEqual(apiKey, "")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

}
