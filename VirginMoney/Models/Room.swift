//
//  Room.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import Foundation

struct Room:Decodable {
    let id: String
    let isOccupied: Bool
    let maxOccupancy: Int
}
