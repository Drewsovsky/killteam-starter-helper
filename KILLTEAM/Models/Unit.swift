//
//  Unit.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//


import SwiftUI

struct Unit : Hashable, Identifiable {
    
    var id: UUID
    
    let title: String
    let APL: Int
    let move: Int
    let save: Int
    let wounds: Int
    
    // MARK: For UI
    let currentWounds: Int
    var imagePath: String?
    
    init(
        id: UUID = UUID.init(),
        title: String,
        APL: Int,
        move: Int,
        save: Int,
        wounds: Int,
        currentWounds: Int? = nil,
        imagePath: String? = nil) {
            self.id = id
            self.title = title
            self.APL = APL
            self.move = move
            self.save = save
            self.wounds = wounds
            self.currentWounds = currentWounds ?? wounds
            self.imagePath = imagePath
    }
    
    var isKilled: Bool { currentWounds <= 0 }
}
