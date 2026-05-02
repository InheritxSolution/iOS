//
//  PerformanceTests.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import XCTest
@testable import app

final class PerformanceTests: XCTestCase {
    
    /// Benchmarks the performance of JSON decoding for large datasets.
    func testHighlightDecodingPerformance() {
        let mockData = createLargeMockData()
        
        self.measure {
            _ = try? JSONDecoder().decode(Highlight.self, from: mockData)
        }
    }
    
    private func createLargeMockData() -> Data {
        // Generates a large JSON string for performance testing
        let post = """
        {
            "id": "1",
            "post_text": "Performance testing post content",
            "highlight_date": "2026-05-02"
        }
        """
        let posts = Array(repeating: post, count: 1000).joined(separator: ",")
        let json = """
        {
            "current_page_index": 1,
            "posts": [\(posts)]
        }
        """
        return json.data(using: .utf8)!
    }
}
