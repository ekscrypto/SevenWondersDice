//
//  Quadrant.swift
//  SevenWondersDice
//
//  Represents a quadrant in the dice box
//

import Foundation

enum Quadrant: Int, CaseIterable, Identifiable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3

    var id: Int { rawValue }

    var cost: Int { rawValue }

    var displayName: String {
        cost == 0 ? "Free" : "\(cost) coin\(cost > 1 ? "s" : "")"
    }
}
