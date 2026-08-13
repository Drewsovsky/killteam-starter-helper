//
//  ContentView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 13.08.2026.
//

import SwiftUI

struct KillteamView: View {
    
    let viewModel: KillteamViewModel
    
    private var squadName: String {
        switch viewModel.state {
        case .loaded(let killteam):
            return killteam.name
        default: return "Roster"
        }
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading, .idle:
                ProgressView("Loading roster...")
            case .failed(let error):
                Text("Error: \(error)")
            case .loaded(let killteam):
                SquadContentView(squad: killteam.squad, onWoundsChange: { unitId, delta in
                    viewModel.changeWounds(for: unitId, by: delta)
                })
            }
        }
        .navigationTitle(squadName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: open information block
                } label : {
                    Image(systemName: "info.circle")
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
    
    struct SquadContentView : View {
        
        var squad: [Unit]
        var onWoundsChange: (UUID, Int) -> Void
        
        @State private var selectedUnitID: UUID?
        
        var body: some View {
            VStack(spacing: 0) {
                pagingControl
                dataCardsPager
            }
            .onAppear {
                if selectedUnitID == nil {
                    selectedUnitID = squad.first?.id
                }
            }
        }
        
        private var pagingControl: some View {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(squad) { unit in
                            Button {
                                withAnimation {
                                    selectedUnitID = unit.id
                                }
                            } label : {
                                Text(unit.title.prefix(1))
                                    .frame(width: 50, height: 50)
                                    .background(selectedUnitID == unit.id ? .green : .black)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(height: 60)
            .background(.orange)
        }
        
        private var dataCardsPager: some View {
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(squad) { unit in
                            cardView(unit: unit) { delta in
                                onWoundsChange(unit.id, delta)
                            }
                            .id(unit.id)
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .scrollTargetLayout()
                }
                .frame(maxHeight: .infinity)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $selectedUnitID)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        
        struct cardView: View {
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
                                    statCell(title: "Move", value: String(unit.move))
                                }
                                GridRow {
                                    statCell(title: "Save", value: String(unit.save))
                                    statCell(title: "Wounds", value: String(unit.wounds))
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
    }
}


#Preview {
    KillteamView(
        viewModel: KillteamViewModel(
            killteamRepository: KillteamLocalRepository()))
}
