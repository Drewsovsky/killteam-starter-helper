//
//  StatView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 14.08.2026.
//


import SwiftUI

struct StatView: View {
    let unit: Unit
    let onWoundsChange: (Int) -> Void
    
    var body: some View {
        VStack {
            Text(unit.title)
                .font(.title)
            HStack(alignment: .top) {
                Image(unit.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading) {
                    Grid {
                        GridRow {
                            statCell(title: "APL", value: String(unit.apl))
                            statCell(
                                title: "Move",
                                value: String(unit.move)
                            )
                        }
                        GridRow {
                            statCell(
                                title: "Save",
                                value: String(unit.save)
                            )
                            statCell(
                                title: "Wounds",
                                value: String(unit.wounds)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            HStack {
                Text("Wounds")
                Spacer()
                HStack {
                    Button("-") { onWoundsChange(-1) }
                    Text("\(unit.currentWounds)/\(unit.wounds)")
                    Button("+") { onWoundsChange(1) }
                }
            }
            
            if let weapons = unit.weapons, !weapons.isEmpty {
                WeaponRowView(weapons: weapons)
            }
            
            if let abilities = unit.abilities, !abilities.isEmpty {
                AbilityRowView(abilities: abilities)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func statCell(title: String, value: String) -> some View {
        VStack {
            Text(title)
            Text(value)
        }
        .frame(maxWidth: .infinity)
    }
}
