//
//  FeedbackView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI
import SwiftData

struct FeedbackView: View {
    @State private var viewModel: FeedbackViewModel
    @Environment(\.modelContext) private var context
    @Environment(AppRouter.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    init(session: Session) {
        self.viewModel = FeedbackViewModel(session: session)
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack(spacing: Theme.Spacing.logSection) {
            VStack(spacing: Theme.Spacing.tight) {
                Text("You were in for")
                    .textStyle(.groupHeader)
                Text(viewModel.duration)
                    .textStyle(.durationHero)
                Text(viewModel.timeline)
                    .textStyle(.rowMeta)
            }
            Form {
                Section {
                    HStack {
                        ForEach(Feel.allCases) { feel in
                            Chip(feel.rawValue, isSelected: viewModel.isSelect(feel)) {
                                viewModel.setFeel(feel)
                            }
                        }
                    }
                } header: {
                    Text("How did it go?")
                        .textStyle(.section)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 1, bottom: Theme.Spacing.rowH, trailing: 1))
                
                Section {
                    HStack {
                        ForEach(Bristol.allCases) { type in
                            Chip(String(type.rawValue), isSelected: viewModel.isSelect(type)) {
                                viewModel.setType(type)
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                } header: {
                    HStack {
                        Text("Type")
                            .textStyle(.section)
                        Spacer()
                        Text(viewModel.bristolType)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 1, bottom: Theme.Spacing.rowH, trailing: 1))
                
                Section {
                    TextField("Coffee this morning, spicy dinner...", text: $viewModel.note, axis: .vertical)
                        .padding()
                        .lineLimit(3...5)
                        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.badge))
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.Radius.badge)
                                .stroke(Theme.Colors.border, lineWidth: 1)
                        )
                } header: {
                    Text("Type")
                        .textStyle(.section)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 1, bottom: Theme.Spacing.rowH, trailing: 1))
            }
            .scrollContentBackground(.hidden)
            .contentMargins(0)
            Spacer()
            Button("Save session" ,role: .confirm) {
                viewModel.save(context: context)
                router.home()
            }.buttonStyle(.plop(.mint))
        }
        .navigationTitle("Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("Back")
                        .textStyle(.link)
                        .fixedSize()
                }
                .buttonStyle(.plain)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, Theme.Spacing.screenH)
        .padding(.top, Theme.Spacing.screenTop)
    }
}

#Preview {
    let now = Date.now
    
    NavigationStack {
        FeedbackView(session: Session(startedAt: now.addingTimeInterval(-1600), endedAt: now.addingTimeInterval(-1200)))
    }
    .modelContainer(for: Session.self, inMemory: true)
    .environment(AppRouter(timer: TimerService()))
}
