//
//  ContentView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import SwiftUI

struct Unit : Hashable, Identifiable {
    
    var id: UUID = UUID.init()
    
    let title: String
    let APL: Int
    let move: Int
    let save: Int
    let wounds: Int
}

struct ContentView: View {
    let squad: [Unit] = [
        Unit(title: "Space Marine Captain", APL: 3, move: 6, save: 3, wounds: 15),
        Unit(title: "Intercessor Sergant", APL: 3, move: 6, save: 3, wounds: 15),
        Unit(title: "Assault Intercessor Warrior", APL: 3, move: 6, save: 3, wounds: 14),
        Unit(title: "Heavy Intercessor Gunner", APL: 3, move: 4, save: 3, wounds: 14),
        Unit(title: "Intercessor Warrior", APL: 3, move: 6, save: 3, wounds: 14),
        Unit(title: "Intercessor Warrior", APL: 3, move: 6, save: 3, wounds: 14),
        Unit(title: "Eliminator Sniper", APL: 3, move: 7, save: 3, wounds: 12)
    ]
    
    @State private var selectedUnit: Unit?
    
    var body: some View {
        VStack {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    pagingControl
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
            .background(.orange)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(squad, id: \.self) { unit in
                        cardView(for: unit)
                    }
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .scrollTargetLayout()
            }
            .frame(maxHeight: .infinity)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selectedUnit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
        .task {
            guard !squad.isEmpty else { return }
            
            selectedUnit = squad[0]
        }
    }
    
    private func cardView(for unit: Unit) -> some View {
        VStack {
            Text(unit.title)
                .font(.title)
            HStack {
                Spacer()
                VStack {
                    Grid {
                        GridRow {
                            statCell(title: "APL", value: String(unit.APL))
                            statCell(title: "Move", value: String(unit.move))
                        }
                        GridRow {
                            statCell(title: "Save", value: String(unit.save))
                            statCell(title: "Wounds", value: String(unit.wounds))
                        }
                    }
                }
            }
        }
    }
    
    private var pagingControl: some View {
        HStack {
            ForEach(squad) { unit in
                Button {
                    withAnimation {
                        selectedUnit = unit
                    }
                } label : {
                    Text(unit.title.prefix(1))
                        .frame(width: 50, height: 50)
                        .background(selectedUnit == unit ? .green : .black)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    private func statCell(title: String, value: String) -> some View {
        VStack {
            Text(title)
            Text(value)
        }
    }
}


#Preview {
    ContentView()
}
