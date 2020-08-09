//
//  WordSearchTests.swift
//  WordSearchTests
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import XCTest
@testable import WordSearch

class WordSearchTests: XCTestCase {
    
    var viewModel: WordSearchViewModel? = nil

    override func setUpWithError() throws {
        viewModel = WordSearchViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testSuccessNetworkSearchDog() {
        let dataExpectation = expectation(description: "Network Data")
        
        var passedTest = false
        
        viewModel?.searchWord("dog") { (result, error) in
            if result != nil {
                passedTest = true
                dataExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(passedTest)
    }
    
    func testSuccessNetworkSearchCyrillicDog() {
        let dataExpectation = expectation(description: "Network Data")
        
        var passedTest = false
        
        viewModel?.searchWord("собака") { (result, error) in
            if result != nil {
                passedTest = true
                dataExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(passedTest)
    }
    
    func testFailedNetworkSearch() {
        let dataExpectation = expectation(description: "No Network Data")
        
        var passedTest = false
        
        viewModel?.searchWord("11111") { (result, error) in
            if let nonEmptyError = error, case CustomReturnEror.noDataInResponse = nonEmptyError {
                passedTest = true
                dataExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(passedTest)
    }
}
