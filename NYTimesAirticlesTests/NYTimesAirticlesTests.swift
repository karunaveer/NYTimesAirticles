//
//  NYTimesAirticlesTests.swift
//  NYTimesAirticlesTests
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import XCTest
@testable import NYTimesAirticles

class NYTimesAirticlesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class ParserTests: XCTestCase {
    var localJson = [String: Any]()
    override func setUp() {
        super.setUp()
    }
    
    func testDecoding_when_Response_Is_Blank() {
        
        let jsonData = """
        {
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response.results.count, 0, "results count is not as expected")
    }
    func testDecoding_Response_With_results_Is_Blank() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results.count, 0, "results count is not as expected")
    }
    //Expected objecttype of results is array but what if its dictionary, Parser should handle that
    func testDecoding_when_Response_With_results_as_a_Dictionary() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": {}
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results.count, 0, "results count is not as expected")
    }
    
    func testDecoding_Response_With_One_results() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
            {
            "media-metadata": [
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-thumbStandard.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo210.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo440.jpg"
            }
          ]
        }
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results.count, 1, "results count is not as expected")
    }

    func testDecoding_Response_With_MoreThanOne_results() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
            {
            "media-metadata": [
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-thumbStandard.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo210.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo440.jpg"
            }
          ]
        }
        ]
        },
        {
        "url": "https://www.nytimes.com/2019/07/23/us/neil-armstrong-wrongful-death-settlement.html",
        "byline": "By SCOTT SHANE and SARAH KLIFF",
        "title": "Neil Armstrong’s Death, and a Stormy, Secret $6 Million Settlement",
        "abstract": "The astronaut’s sons contended that incompetent medical care had cost him his life, and threatened to go public. His widow says she wanted no part of the payout.",
        "published_date": "2019-07-23",
        "media": [
        {
        "media-metadata": [
        {
          "url": "https://static01.nyt.com/images/2019/07/23/multimedia/23armstrong/23armstrong-thumbStandard.jpg"
        },
        {
          "url": "https://static01.nyt.com/images/2019/07/23/multimedia/23armstrong/23armstrong-mediumThreeByTwo210-v2.jpg"
        },
        {
          "url": "https://static01.nyt.com/images/2019/07/23/multimedia/23armstrong/23armstrong-mediumThreeByTwo440-v2.jpg"
        }
        ]
        }
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results.count, 2, "results count is not as expected")
        
        XCTAssertEqual(response.results[0].articleUrl, "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html")
        XCTAssertEqual(response.results[1].articleUrl, "https://www.nytimes.com/2019/07/23/us/neil-armstrong-wrongful-death-settlement.html")

    }

    func testDecoding_Response_When_mediaIsMissing() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16"
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results[0].media.count, 0)
    }
    func testDecoding_Response_When_mediaIsBlank() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results[0].media.count, 0)
    }
    
    func testDecoding_check_url_Is_equal_to_GivenValue() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
            {
            "media-metadata": [
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-thumbStandard.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo210.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo440.jpg"
            }
          ]
        }
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)

        XCTAssertEqual(response.results[0].articleUrl, "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html")
    }
    
    
    func testDecoding_when_url_Key_Is_Missing() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "byline": "By THOMAS L. FRIEDMAN",
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
            {
            "media-metadata": [
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-thumbStandard.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo210.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo440.jpg"
            }
          ]
        }
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results[0].articleUrl, "")
    }
    
    //Expected objecttype of byline is String but what if its Number, Parser should handle that
    func testDecoding_when_byline_has_Number_instead_of_String() {
        
        let jsonData = """
        {"status": "OK",
        "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
        "num_results": 1710,
        "results": [
        {
        "url": "https://www.nytimes.com/2019/07/16/opinion/trump-2020.html",
        "byline": 10,
        "title": "‘Trump’s Going to Get Re-elected, Isn’t He?’",
        "abstract": "Voters have reason to worry.",
        "published_date": "2019-07-16",
        "media": [
            {
            "media-metadata": [
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-thumbStandard.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo210.jpg"
            },
            {
              "url": "https://static01.nyt.com/images/2019/07/16/opinion/16friedman1/16friedman1-mediumThreeByTwo440.jpg"
            }
          ]
        }
        ]
        }
        ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(response.results[0].byLine, "")
        
    }
}

class WebServiceCallTests: XCTestCase {
    
    func testNyTimesArticleApicall_With_Wrong_ApiKey() {
        let expectation = self.expectation(description: "Wait for api response")

        let endPoint = AirticleEndpoint.airticles(apiKey: AirticleClient.apiKey + "test")
        
        AirticleClient.shared.fetch(with: endPoint ) { (result) in
            
            switch result {
            case .error(let error) :
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (NYTimesAirticles.APIError error 1.)")
            case .success(_):
                XCTFail("Expected Error but received response")
            }
            expectation.fulfill()

        }
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testNyTimesArticleApicall_With_Right_ApiKey() {
        let expectation = self.expectation(description: "Wait for api response")

        let endPoint = AirticleEndpoint.airticles(apiKey: AirticleClient.apiKey)
        
        AirticleClient.shared.fetch(with: endPoint ) { (result) in
            
            switch result {
            case .error(_) :
                XCTFail("Expected Response but received error")
            case .success(let airticles) :
                XCTAssertNotNil(airticles)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 60.0, handler: nil)
    }
}
