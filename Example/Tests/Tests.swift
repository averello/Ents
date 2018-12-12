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

    // MARK: - Map
    
    func testConcurrentMap() {
        let base = Array((0..<10))
        let transform = { (item: Int) -> Int in item * 2 }
        let array = base.concurrentMap(transform)
        let expected = base.map(transform)
        XCTAssertEqual(array, expected)
    }

    @available(iOS 10.0, *)
    func testConcurrentMapPerformance() {
        let base = Array((0..<100_000))
        let transform = { (item: Int) -> Int in item * 2 }
        self.measure {
            let _ = base.concurrentMap(qos: .userInteractive,
                                       lock: .spinLock,
                                       transform)
        }
    }

    func testMapPerformance() {
        let base = Array((0..<100_000))
        let transform = { (item: Int) -> Int in item * 2 }
        self.measure {
            let _ = base.map(transform)
        }
    }

    // MARK: - Flat Map

    func testConcurrentFlatMap() {
        let base = Array((0..<10)).map({ Array(repeating: $0, count: $0) })
        let transform = { (item: [Int]) -> [Int] in item.map({$0 * 2}) }
        let array = base.concurrentFlatMap(transform)
        let expected = base.flatMap(transform)
        XCTAssertEqual(array, expected)
    }

    func testConcurrentFlatMapPerformance() {
        let base = Array((0..<1_000)).map({ Array(repeating: $0, count: $0) })
        let transform = { (item: [Int]) -> [Int] in item.map({$0 * 2}) }
        self.measure {
            let _ = base.concurrentFlatMap(qos: .userInteractive,
                                           lock: .spinLock,
                                           transform)
        }
    }

    func testFlatMapPerformance() {
        let base = Array((0..<1_000)).map({ Array(repeating: $0, count: $0) })
        let transform = { (item: [Int]) -> [Int] in item.map({$0 * 2}) }
        self.measure {
            let _ = base.flatMap(transform)
        }
    }

    // MARK: - Compact Map

    func testConcurrentCompactMap() {
        let base = Array((0..<10))
        let transform = { (item: Int) -> Int? in return item % 2 == 0 ? item : nil }
        let array = base.concurrentCompactMap(transform)
        let expected = base.compactMap(transform)
        XCTAssertEqual(array, expected)
    }

    func testConcurrentCompactMapPerformance() {
        let base = Array((0..<100_000))
        let transform = { (item: Int) -> Int? in return item % 2 == 0 ? item : nil }
        self.measure {
            let _ = base.concurrentCompactMap(qos: .userInteractive,
                                              lock: .spinLock,
                                              transform)
        }
    }

    func testCompactMapPerformance() {
        let base = Array((0..<100_000))
        let transform = { (item: Int) -> Int? in return item % 2 == 0 ? item : nil }
        self.measure {
            let _ = base.compactMap(transform)
        }
    }

    // MARK: - Filter

    func testConcurrentFilter() {
        let base = Array((0..<10))
        let isIncluded = { (item: Int) -> Bool in return item % 2 == 0 }
        let array = base.concurrentFilter(isIncluded)
        let expected = base.filter(isIncluded)
        XCTAssertEqual(array, expected)
    }


    func testConcurrentFilterPerformance() {
        let base = Array((0..<100_000))
        let isIncluded = { (item: Int) -> Bool in return item % 2 == 0 }
        self.measure {
            let _ = base.concurrentFilter(qos: .userInteractive,
                                          lock: .spinLock,
                                          isIncluded)
        }
    }

    func testFilterPerformance() {
        let base = Array((0..<100_000))
        let isIncluded = { (item: Int) -> Bool in return item % 2 == 0 }
        self.measure {
            let _ = base.filter(isIncluded)
        }
    }
}
