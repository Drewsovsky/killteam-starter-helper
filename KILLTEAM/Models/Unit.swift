//
//  Unit.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//


import SwiftUI

struct Unit : Hashable, Identifiable {
    
    let id: UUID
    
    let title: String
    let apl: Int
    let move: Int
    let save: Int
    let wounds: Int
    let imageName: String
    
    // MARK: For UI
    var currentWounds: Int
    var imagePath: String?
    
    init(
        id: UUID,
        title: String,
        apl: Int,
        move: Int,
        save: Int,
        wounds: Int,
        imageName: String?,
        currentWounds: Int? = nil,
        imagePath: String? = nil) {
            self.id = id
            self.title = title
            self.apl = apl
            self.move = move
            self.save = save
            self.wounds = wounds
            self.imageName = imageName ?? ""
            self.currentWounds = currentWounds ?? wounds
            self.imagePath = imagePath
    }
    
    var isKilled: Bool { currentWounds <= 0 }
}
