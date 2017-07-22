//
//  CriteriaBuilder.swift
//  IdylleClient
//
//  Created by Benoit BRIATTE on 22/07/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public class CriteriaBuilder {

    public var `where`: [String: Any] = [:]
    private var sort: [String] = []
    public var includes: [Include] = []
    public var fields: [String] = []
    public var fieldMode: FieldMode = .exclude
    public var limit: Int?
    public var offset: Int?

    @discardableResult
    public func sort(using field: String, ordering: Ordering) -> CriteriaBuilder {
        let direction = ordering == Ordering.desc ? "-" : ""
        self.sort.append("\(direction)\(field)")
        return self
    }

    public func build() -> String? {
        var criteriaClause: [String: Any] = [:]
        if self.where.count > 0 {
            criteriaClause["where"] = self.where
        }
        if self.includes.count > 0 {
            criteriaClause["includes"] = self.includes.map { $0.build() }
        }
        if self.sort.count > 0 {
            criteriaClause["sort"] = self.sort.joined(separator: " ")
        }
        if self.fields.count > 0 {
            if self.fieldMode == .exclude {
                criteriaClause["fields"] = self.fields.map { "-\($0)" }
            } else {
                criteriaClause["fields"] = self.fields
            }
        }
        if let limit = self.limit {
            criteriaClause["limit"] = limit
        }
        if let offset = self.offset {
            criteriaClause["offset"] = offset
        }
        guard criteriaClause.count > 0,
            let criteriaData = try? JSONSerialization.data(withJSONObject: criteriaClause),
            let criteria = String(data: criteriaData, encoding: .utf8) else {
                return nil
        }
        return criteria
    }
}

extension CriteriaBuilder { // Nested Types

    public enum Keys {
        public static let criteria = "criteria"
    }

    public enum Ordering {
        case asc
        case desc
    }

    public enum FieldMode {
        case include
        case exclude
    }

    public class Include {
        public var field: String
        public var children: [Include]?

        init(field: String, children: [Include]? = nil) {
            self.field = field
            self.children = children
        }

        fileprivate func build() -> Any {
            if let children = self.children {
                let count = children.count
                if count >= 0 {
                    if count > 0 {
                        return [
                            self.field: children.map { $0.build() }
                        ]
                    }
                    return [self.field: children[0].build()]
                }
            }
            return self.field
        }
    }
}
