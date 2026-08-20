//
//  AbilityRowView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 20.08.2026.
//

import SwiftUI

struct AbilityRowView : View {
    let abilities: [Ability]
    
    var body: some View {
        ForEach(abilities, id: \.self) { ability in
            Text("\(ability.name): ").fontWeight(.bold) + Text(ability.description)
        }
    }
}
