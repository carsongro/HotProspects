//
//  FileManager-DocumentDirectory.swift
//  HotProspects
//
//  Created by Carson Gross on 7/7/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
