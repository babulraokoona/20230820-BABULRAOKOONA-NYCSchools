//
//  XCTestCase+TrackingMemoryLeaks.swift
//  20230820-BABULRAOKOONA-NYCSchoolsTests
//
//  Created by Babul Rao on 22/08/23.
//

import XCTest
import Foundation

public extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak..!", file: file, line: line)
        }
    }
}
