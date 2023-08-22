//
//  SchoolDataModelTests.swift
//  20230820-BABULRAOKOONA-NYCSchoolsTests
//
//  Created by Babul Rao on 22/08/23.
//

import XCTest
import Combine

class SchoolDataModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let (viewModelToTest, _) = makeSUT()
        XCTAssertTrue(viewModelToTest.schools.isEmpty)
        XCTAssertFalse(viewModelToTest.hasError)
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_fetchSchoolData_loading() {
        let (viewModelToTest, _) = makeSUT()
        let expectation = XCTestExpectation(description: "State is set to Loading")
        viewModelToTest.$state.dropFirst().sink { state in
            XCTAssertEqual(state, .loading)
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModelToTest.fetchSchoolData()
        wait(for: [expectation], timeout: 1)
    }
    func test_fetchSchoolData_success() {
        let (viewModelToTest, mockClient) = makeSUT()
        let schoolsToTest = MockSchools()
        let expectation = XCTestExpectation(description: "State is set to success")
        
        viewModelToTest.$state.dropFirst().sink { state in
            switch state {
            case .success(let schools):
                XCTAssertEqual(schools.count, schoolsToTest.count)
                guard let school = schools.first else {
                    return
                }
                let schoolToTest = schoolsToTest[0]
                XCTAssertEqual(school.id, schoolToTest.id)
                XCTAssertEqual(school.schoolName, schoolToTest.schoolName)
                XCTAssertEqual(school.overview, schoolToTest.overview)
                XCTAssertEqual(school.phoneNumber, schoolToTest.phoneNumber)
                XCTAssertEqual(school.website, schoolToTest.website)
                expectation.fulfill()
            default :
                print("Other than Success")
            }
        }.store(in: &cancellables)

        mockClient.resultType = .success
        mockClient.schools = schoolsToTest
        
        viewModelToTest.fetchSchoolData()
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchSchoolData_failure() {
        let (viewModelToTest, mockClient) = makeSUT()
        let errorToTest = anyError()
        let expectation = XCTestExpectation(description: "State is set to failure")
        viewModelToTest.$state.dropFirst().sink { state in
            switch state {
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, (errorToTest as NSError).code)
                expectation.fulfill()
            default :
                print("Other than failure")
            }
        }.store(in: &cancellables)

        mockClient.resultType = .failure
        mockClient.error = errorToTest
        
        viewModelToTest.fetchSchoolData()
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: SchoolDataModel, spy: MockAPIClient) {
        let spy = MockAPIClient()
        let sut = SchoolDataModel(client: spy)
        trackForMemoryLeaks(spy, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, spy)
    }
}

private extension SchoolDataModelTests {
    final class MockAPIClient: APIClient {
        enum ResultType {
            case success
            case failure
        }
        var schools:[SchoolModel]!
        var error = anyError()
        var resultType = ResultType.failure
        func request<T: Decodable>(_ endPoint: APIEndPoint, ofType type: T.Type) -> FuturePublisher<T> {
            return FuturePublisher<T> { [weak self] promise in
                guard let self = self else { return }
                switch self.resultType {
                case .success:
                    promise(.success(self.schools as! T))
                case .failure:
                    promise(.failure(self.error))
                }
            }
        }
    }
}
