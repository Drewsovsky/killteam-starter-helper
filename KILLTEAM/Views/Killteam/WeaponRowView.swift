//
//  WeaponRowView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 14.08.2026.
//

import SwiftUI

struct WeaponRowView: View {
    let weapons: [Weapon] 
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Weapons")
            VStack {
                ForEach(weapons, id: \.self) { weapon in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: weapon.isRanged ? "scope" : "hammer")
                            Text(weapon.name)
                        }
                        HStack {
                            Text("ATK:\(weapon.attacks)")
                            Text("HIT:\(weapon.hit)")
                            Text("DMG:\(weapon.damage)")
                        }
                        if let rules = weapon.rules, !rules.isEmpty {
                            Text("Weapon Rules: \(rules.joined(separator: ", "))")
                        }
                        Divider()
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    WeaponRowView(repository: KillteamLocalRepository())
//}
