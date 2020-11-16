//
//  Item.swift
//  TheHat
//
//  Created by Christopher Papa on 11/13/20.
//
import SwiftUI
import Combine

struct Item: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isEligible: Bool = true
    
    init(name: String) {
        self.name = name
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        lhs.name > rhs.name
    }
}
