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
    
    func testExample() {
        // This is an example of a functional test case.
        let parent = UIView(frame: CGRect.zero.with(size: CGSize(width: 100, height: 50)))
        let child = UIView(frame: CGRect.zero.with(size: CGSize(width: 50, height: 25)))
        
        let layout = UIView.equal(\.frameLeftCenter, \.ownLeftCenter)
        layout(child, parent)
        let childFrame = child.frame
        UIView.equalLeftCenters(child, parent)
        XCTAssert((childFrame == child.frame), "Pass")
        
        XCTAssert((child.frameLeftCenter == parent.ownLeftCenter), "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
