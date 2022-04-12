//
//  NewsListViewModelTests.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import XCTest

class NewsListViewModelTests: XCTestCase {
    private var sut: NewsListViewModel!
    private var nyTimesAPIClient: NYTimesAPIMock!
    private var title: String!
    private var delegate: NewsListViewDelegateMock!

    override func setUp() {
        super.setUp()
        nyTimesAPIClient = NYTimesAPIMock()
        title = "News"
        delegate = NewsListViewDelegateMock()
        sut = NewsListViewModel(title: title, nyTimesAPIClient: nyTimesAPIClient)
        sut.delegate = delegate
    }

    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
        nyTimesAPIClient = nil
        title = nil
        delegate = nil
    }

    func testTitle() {
        XCTAssertEqual(sut.title, title)
    }

    func testFetchData() {
        // When
        sut.fetchData()

        // Then
        XCTAssertEqual(delegate.didStartFetchingDataCallsCount, 1)
        XCTAssertEqual(nyTimesAPIClient.fetchNewsCompletionCallsCount, 1)
    }

    func testRefresh() {
        // When
        sut.refresh()

        // Then
        XCTAssertEqual(delegate.willRefreshDataCallsCount, 1)
        XCTAssertEqual(delegate.didStartFetchingDataCallsCount, 1)
    }
}
