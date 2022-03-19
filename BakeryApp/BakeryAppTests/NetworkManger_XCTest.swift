//
//  BakeryAppTests.swift
//  BakeryAppTests
//
//  Created by Abhishek Kumar on 16/03/22.
//

import XCTest
@testable import BakeryApp

class NetworkManger_XCTest: XCTestCase {
    
    var networkService: NetworkProtocol?
    
    override func setUp() {
        super.setUp()
        networkService = NetworkManager.shared
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func test_Network_manager_api_call_for_Item_get() {
        
        let expectation = XCTestExpectation(description: "items response")
        
        let request = ItemRequest.get
        
        networkService?.request(routerRequest: request, type: Items.self) { result  in
            guard case .success(let items) = result else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(items)
            XCTAssertNotEqual(items.count, 0 , "count is not equal zero")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
}
