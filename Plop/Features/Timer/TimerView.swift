//
//  TimerView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI
import Combine

struct TimerView: View {
    @State private var viewModel: TimerViewModel
    @State private var progress: Double = 0.5
    @State private var router: AppRouter
    @Environment(SettingService.self) private var settings: SettingService
    
    init(timer: TimerService, router: AppRouter) {
        viewModel = TimerViewModel(service: timer, router: router)
        self.router = router
    }
    
    var body: some View {
        let isPastNudge = viewModel.calculateRemainingNudge() <= .seconds(0)
        let nudgeMessage = isPastNudge ? "Time to wrap up?" : "Gentle nudge in \(viewModel.willNudgeAt)"
        let hintMessage = viewModel.isReady ? nudgeMessage : "Nudge paused"
        
        VStack(spacing: Theme.Spacing.screenH * 2) {
            Spacer()
            ZStack {
                Circle()
                    .stroke(Theme.Colors.ringTrack, lineWidth: Theme.Size.ringStroke)
                Circle()
                    .trim(from: 0, to: max(min(viewModel.progress, 1), 0))
                    .stroke(Theme.Colors.mintDeep, style: StrokeStyle(lineWidth: Theme.Size.ringStroke, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: viewModel.progress)
                VStack (spacing: Theme.Spacing.group) {
                    Text(viewModel.clock).textStyle(.timerClock)
                        Text("Started at \(viewModel.startedAt)")
                }
            }
            .frame(width: Theme.Size.timerRing)
            if settings.isNudgeOn {
                HStack {
                    Image(systemName: "bell")
                        .foregroundStyle(Theme.Colors.mintDeep)
                    Text(hintMessage)
                        .id(hintMessage)
                        .font(Theme.Fonts.hint)
                        .transition(.push(from: .bottom))
                        .frame(maxWidth: .infinity)
                }
                .containerRelativeFrame(.horizontal, alignment: .leading) { width, _ in
                    width / 2
                }
                .animation(.smooth, value: hintMessage)
                .padding()
                .background(Theme.Colors.mintSoft)
                .clipShape(.rect(cornerRadius: Theme.Radius.pill))
            }
            Spacer()
            HStack {
                Button(viewModel.pauseButtonText, systemImage: viewModel.pauseButtonIcon) {
                    viewModel.togglePause()
                }
                .buttonStyle(.plop(.outline))
                Button("Done") {
                    viewModel.done()
                }.buttonStyle(.plop(.highlight))
            }
        }
        .padding(.horizontal, Theme.Spacing.screenH)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.cancel()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.timerBackground)
        .onReceive(viewModel.timer) { _ in
            viewModel.tick()
        }
        .onChange(of: router.draft) { old, new in
            if old != nil && new == nil {
                viewModel.resume()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("In session")
                    .textStyle(.rowTitle)
            }
        }
    }
}

#Preview {
    let previewDefaults = UserDefaults.preview([SettingKey.nudgeDuration: 10])
    let settings = SettingService(defaults: previewDefaults)
    
    let timer = TimerService(defaults: previewDefaults, settings: settings)
    timer.start()
    
    return NavigationStack {
            TimerView(timer: timer, router: AppRouter(timer: timer))
    }
    .environment(settings)
}
