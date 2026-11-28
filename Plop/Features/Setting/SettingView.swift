//
//  SettingView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import SwiftUI

struct SettingView: View {
    @State private var viewModel: SettingViewModel
    @Environment(AppRouter.self) private var router

    init(service: SettingService) {
        viewModel =  SettingViewModel(service: service)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.listSection) {
                Text("Settings")
                    .textStyle(.largeTitle)
                    .padding(.bottom, Theme.Spacing.screenTop)

                SettingSection("Timer") {
                    SettingToggle(
                        "Gentle nudge",
                        systemName: "bell",
                        style: .green,
                        isOn: $viewModel.isNudgeOn.animation(.snappy)
                    )
                    if viewModel.isNudgeOn {
                        SettingOnNudge(nudge: $viewModel.nudgeDuration)
                    }
                    SettingToggle(
                        "Timer on Lock Screen",
                        systemName: "platter.filled.top.iphone",
                        style: .green,
                        isOn: $viewModel.isTimerOnLockScreen
                    )
                    SettingToggle(
                        "Haptics",
                        systemName: "iphone.gen2.radiowaves.left.and.right",
                        style: .green,
                        isOn: $viewModel.isHaptics
                    )
                }
                SettingSection("Reminders") {
                    SettingToggle(
                        "Daily check-in",
                        systemName: "calendar",
                        style: .yellow,
                        isOn: $viewModel.isDailyCheckin
                    )
                }
                SettingSection("Privacy & Data") {
                    SettingToggle(
                        "Lock with Face ID",
                        systemName: "lock",
                        isOn: $viewModel.isFaceIDOn
                    )
                    SettingToggle(
                        "iCloud sync",
                        systemName: "cloud",
                        isOn: $viewModel.isCloudSyncOn
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        router.closeSetting()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .textStyle(.link)
                            Text("Home")
                                .textStyle(.link)
                                .fixedSize()
                        }
                    }
                    .buttonStyle(.plain)
                }
                .sharedBackgroundVisibility(.hidden)
            }
            .padding(.bottom, Theme.Spacing.settingsBottom)
            .padding(.horizontal, Theme.Spacing.settingsH)
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(service: SettingService(defaults: .preview([SettingKey.isNudgeOn: true])))
    }
    .environment(AppRouter(timer: TimerService(defaults: .preview())))
}
