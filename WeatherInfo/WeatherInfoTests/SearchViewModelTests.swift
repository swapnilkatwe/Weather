//
//  SearchViewModelTests.swift
//  WeatherInfoTests
//
//  Created by swapnil.suresh.katwe on 20/03/23.
//

import XCTest
@testable import WeatherInfo

final class SearchViewModelTests: XCTestCase {

    var subject: SearchViewModel!

    override func setUp() {
        super.setUp()
        subject = SearchViewModel()
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
    }

    func testAllProperties() {
        XCTAssertNotNil(subject.numberOfCell)
        XCTAssertNotNil(subject.searchCity(text: "Pune"))
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
