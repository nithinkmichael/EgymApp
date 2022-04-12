//
//  NYTimesAPITests.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import XCTest

class NYTimesAPITests: XCTestCase {

    private var sut: NYTimesAPI!
    private var networkService: NetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        sut = .init(networkService: networkService)
    }
    
    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
        networkService = nil
    }
    
    func testFetchNews() {
        // When
        sut.fetchNews { result in
            // Then
            XCTAssertEqual(self.networkService.executeUrlRequestCompletionCallsCount, 1)
        }
    }

}
