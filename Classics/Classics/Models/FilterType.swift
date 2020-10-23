//
//  FilterType.swift
//  Classics
//
//  Created by Albert Kornas on 10/23/20.
//

import Foundation

enum FilterType: String, Codable, Identifiable, CaseIterable {
    var id: String {self.rawValue}
    case all = "All"
    case completed = "Completed Books"
    case unfinished = "Currently Reading"
}
