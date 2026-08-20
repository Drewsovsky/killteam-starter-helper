//
//  AbilityRowView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 20.08.2026.
//

import SwiftUI

struct AbilityRowView : View {
    let ability: Ability
    
    var body: some View {
        Text("\(ability.name): ").fontWeight(.bold) + Text(ability.description)
    }
}
