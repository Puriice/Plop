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
    
    init(service: TimerService, router: AppRouter) {
        viewModel = TimerViewModel(service: service, router: router)
        self.router = router
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(Theme.Colors.ringTrack, lineWidth: Theme.Size.ringStroke)
                Circle()
                    .trim(from: 0, to: max(min(progress, 1), 0))
                    .stroke(Theme.Colors.mintDeep, style: StrokeStyle(lineWidth: Theme.Size.ringStroke, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.4), value: progress)
                VStack (spacing: Theme.Spacing.group) {
                    Text(viewModel.clock).textStyle(.timerClock)
                    Text("Started at \(viewModel.startedAt)")
                }
            }
            .frame(width: Theme.Size.timerRing)
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
    let timer = TimerService()
    timer.start()
    
    return NavigationStack {
            TimerView(service: timer, router: AppRouter(timer: timer))
    }
}
