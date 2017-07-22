import XCTest
@testable import IdylleClient

class IdylleClientTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLimitOffset() {
        let criteriaBuilder = CriteriaBuilder()
        criteriaBuilder.limit = 5
        criteriaBuilder.offset = 12

        guard let criteria = criteriaBuilder.build() else {
            XCTFail("Cannot build criteria")
            return
        }
        XCTAssertEqual(criteria, "{\"offset\":12,\"limit\":5}")
    }

    func testWhereClauseAndSortFields() {
        let criteriaBuilder = CriteriaBuilder()
        criteriaBuilder.fields.append("friends")
        criteriaBuilder.where["company_name"] = "Digipolitan"

        guard let criteria = criteriaBuilder.build() else {
            XCTFail("Cannot build criteria")
            return
        }
        XCTAssertEqual(criteria, "{\"fields\":[\"-friends\"],\"where\":{\"company_name\":\"Digipolitan\"}}")
    }

    func testIncludeFieldsAndSort() {
        let criteriaBuilder = CriteriaBuilder()
        criteriaBuilder.fieldMode = .include
        criteriaBuilder.fields.append("friends")
        criteriaBuilder.sort(using: "date", ordering: .desc)

        guard let criteria = criteriaBuilder.build() else {
            XCTFail("Cannot build criteria")
            return
        }
        XCTAssertEqual(criteria, "{\"fields\":[\"friends\"],\"sort\":\"-date\"}")
    }

    func testIncludeObject() {
        let criteriaBuilder = CriteriaBuilder()
        criteriaBuilder.includes.append(.init(field: "friends"))

        guard let criteria = criteriaBuilder.build() else {
            XCTFail("Cannot build criteria")
            return
        }
        XCTAssertEqual(criteria, "{\"includes\":[\"friends\"]}")
    }

    func testNestedIncludeObjects() {
        let criteriaBuilder = CriteriaBuilder()
        criteriaBuilder.includes.append(.init(field: "friends", children: [
            .init(field: "family", children: [
                .init(field: "friends")
                ]),
            .init(field: "address")
            ]))

        guard let criteria = criteriaBuilder.build() else {
            XCTFail("Cannot build criteria")
            return
        }
        XCTAssertEqual(criteria, "{\"includes\":[{\"friends\":[{\"family\":[\"friends\"]},\"address\"]}]}")
    }
}
