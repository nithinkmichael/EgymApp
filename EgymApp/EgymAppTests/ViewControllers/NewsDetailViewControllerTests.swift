//
//  NewsDetailViewControllerTests.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import XCTest

class NewsDetailViewControllerTests: XCTestCase {

    private var sut: NewsDetailViewController!
    private var viewModel: NewsDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = NewsDetailViewModel(title: "test title", description: "test description", author: "test author", imageUrl: "", newsUrl: "")
        sut = .viewController(viewModel: viewModel)
    }

    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
        viewModel = nil
    }
    
    func testViewDidLoad() {

    }

}
