//
//  Prospect.swift
//  HotProspects
//
//  Created by Carson Gross on 7/4/22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var addedTime = Date.now
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
//    let saveKey = "SavedData"
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        //no saved data!
//        people = []
        
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            //no save data!
            people = []
        }
    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unabel to save data")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}

extension Prospect: Comparable {
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        if lhs.name == rhs.name {
            return lhs.name.lowercased() < rhs.name.lowercased()
        }
        return lhs.name.lowercased() < rhs.name.lowercased()

    }
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        if lhs.name == rhs.name {
            return lhs.name.lowercased() < rhs.name.lowercased()
        }
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
}
