//
//  SquadContentView.swift
//  KILLTEAM
//
//  Created by Andrew Shakula on 14.08.2026.
//

import SwiftUI

struct SquadContentView: View {

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
                        VStack(spacing: 0) {
                            Button {
                                withAnimation {
                                    selectedUnitID = unit.id
                                }
                            } label: {
                                Text(unit.title.prefix(1))
                                    .frame(width: 50, height: 50)
                                    .background(
                                        selectedUnitID == unit.id ? .green : .black
                                    )
                                    .foregroundColor(.white)
                            }
                            ProgressView(value: Double(unit.currentWounds) / Double(unit.wounds)).progressViewStyle(.linear)
                        }
                    }
                }
                .padding()
            }
        }
        .frame(height: 60)
    }

    private var dataCardsPager: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(squad) { unit in
                        ScrollView {
                            StatView(unit: unit) { delta in
                                onWoundsChange(unit.id, delta)
                            }
                            .id(unit.id)
                        }
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
    }
}
