//
//  NewsListViewControllerTests.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import XCTest

class NewsListViewControllerTests: XCTestCase {
    private var sut: NewsListViewController!
    private var viewModel: NewsListViewModelProtocolMock!

    override func setUp() {
        super.setUp()
        sut = NewsListViewController()
        viewModel = NewsListViewModelProtocolMock()
        sut.viewModel = viewModel
    }

    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
        viewModel = nil
    }

    func testViewDidLoad() {
        // Given
        let title = "News"
        viewModel.underlyingTitle = title

        // When
        _ = sut.view

        // Then
        XCTAssertEqual(viewModel.fetchDataCallsCount, 1)
        XCTAssertEqual(sut.title, title)
    }
}
