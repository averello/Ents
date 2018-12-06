import UIKit
import XCTest
import Ents

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcurrentMap() {
        let base = Array((0..<10))
        let transform = { (item: Int) -> Int in item * 2 }
        let array = base.concurrentMap(transform)
        let expected = base.map(transform)
        XCTAssertEqual(array, expected)
    }

    func testConcurrentFlatMap() {
        let base = Array((0..<10)).map({ Array(repeating: $0, count: $0) })
        let transform = { (item: [Int]) -> [Int] in item.map({$0 * 2}) }
        let array = base.concurrentFlatMap(transform)
        let expected = base.flatMap(transform)
        XCTAssertEqual(array, expected)
    }

    func testConcurrentCompactMap() {
        let base = Array((0..<10))
        let transform = { (item: Int) -> Int? in return item % 2 == 0 ? item : nil }
        let array = base.concurrentCompactMap(transform)
        let expected = base.compactMap(transform)
        XCTAssertEqual(array, expected)
    }
}
