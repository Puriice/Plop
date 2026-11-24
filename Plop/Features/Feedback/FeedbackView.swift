//
//  FeedbackView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftData
import SwiftUI

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

        ZStack {
            Theme.Colors.background.ignoresSafeArea()
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
                                Chip(
                                    feel.rawValue,
                                    isSelected: viewModel.isSelect(feel),
                                    selectedForeground: feel.Foreground(),
                                    selectedBackground: feel.Background()
                                ) {
                                    viewModel.setFeel(feel)
                                }
                            }
                        }
                    } header: {
                        Text("How did it go?")
                            .textStyle(.section)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 1,
                            bottom: Theme.Spacing.rowH,
                            trailing: 1
                        )
                    )

                    Section {
                        HStack {
                            ForEach(Bristol.allCases) { type in
                                Chip(
                                    String(type.rawValue),
                                    isSelected: viewModel.isSelect(type),
                                    selectedForeground: type.Foreground(),
                                    selectedBackground: type.Background()
                                ) {
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
                    .listRowBackground(Color.clear)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 1,
                            bottom: Theme.Spacing.rowH,
                            trailing: 1
                        )
                    )

                    Section {
                        TextField(
                            "Coffee this morning, spicy dinner...",
                            text: $viewModel.note,
                            axis: .vertical
                        )
                        .padding()
                        .lineLimit(3...5)
                        .clipShape(
                            RoundedRectangle(cornerRadius: Theme.Radius.badge)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.Radius.badge)
                                .stroke(Theme.Colors.border, lineWidth: 1)
                        )
                    } header: {
                        Text("Note")
                            .textStyle(.section)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 1,
                            bottom: Theme.Spacing.rowH,
                            trailing: 1
                        )
                    )
                }
                .scrollContentBackground(.hidden)
                .contentMargins(0)
                Spacer()
                Button("Save session", role: .confirm) {
                    if viewModel.draft {
                        viewModel.save(context: context)
                        router.home()
                    } else {
                        dismiss()
                    }
                }.buttonStyle(.plop(.mint))
            }
        }
        .background(Theme.Colors.background)
        .navigationTitle("Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .containerBackground(Theme.Colors.background, for: .navigation)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    if viewModel.draft {
                        Text("Back")
                            .textStyle(.link)
                            .fixedSize()
                    } else {
                        Text("Cancel")
                            .textStyle(.link)
                            .fixedSize()
                    }
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
        FeedbackView(
            session: Session(
                startedAt: now.addingTimeInterval(-1600),
                endedAt: now.addingTimeInterval(-1200)
            )
        )
    }
    .modelContainer(for: Session.self, inMemory: true)
    .environment(AppRouter(timer: TimerService()))
}
