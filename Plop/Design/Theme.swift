//
//  Theme.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 21/11/2569 BE.
//

//
//  Theme.swift
//  Plop
//
//  Design tokens, synced with the design canvas:
//  https://claude.ai/artifact/BN15WTmhBLET1bYyejPgWE  (Home, Timer, Log, History, Stats)
//
//  Views should never use raw hex values, font sizes or magic numbers —
//  always go through Theme.*.
//

import SwiftUI
import UIKit

enum Theme {
    
    // MARK: Colors
    enum Colors {
        // Neutrals
        static let background    = Color(hex: 0xFBFAF7)   // screen background
        static let surface       = Color(hex: 0xFFFFFF)   // cards, tab bar, inputs, selected segment
        static let surfaceMuted  = Color(hex: 0xEFECE6)   // settings button, segmented track
        static let border        = Color(hex: 0xECE8E1)   // card borders, row dividers, tab bar top
        static let borderStrong  = Color(hex: 0xDDD7CE)   // unselected chips, text field border
        static let textPrimary   = Color(hex: 0x1F1A17)   // main text, text on mint & yellow
        static let textSecondary = Color(hex: 0x6B6560)   // labels, meta, inactive tabs, Skip
        
        // Brand – mint (always dark text on it, never white)
        static let mint          = Color(hex: 0xA0E1C3)   // hero card, Timer background, Save button
        static let mintDeep      = Color(hex: 0x1F6F55)   // links, active tab, selected chip, ring, selected bar, badge text
        static let mintPressed   = Color(hex: 0x17533F)   // pressed links
        static let mintSoft      = Color(hex: 0xDDF4E8)   // selected chip fill, type badge
        static let mintBar       = Color(hex: 0xC4EBD8)   // unselected chart bars
        
        // Highlight – yellow crown
        static let highlight     = Color(hex: 0xFDE68A)   // Start, Done
        static let highlightSoft = Color(hex: 0xFEF3C7)   // insight card
        static let highlightText = Color(hex: 0x78350F)   // insight card text
        static let highlightIcon = Color(hex: 0x92400E)   // insight card lightbulb
        
        // On-mint translucency
        static let onMint        = Color.white.opacity(0.55)  // ✕ button, hint pill
        static let haloInner     = Color.white.opacity(0.45)  // Start button ring 1
        static let haloOuter     = Color.white.opacity(0.22)  // Start button ring 2
        static let ringTrack     = mintDeep.opacity(0.15)     // timer ring track
        
        // Misc
        static let segmentShadow = Color.black.opacity(0.12)
    }
    
    // MARK: Typography
    // Nunito if bundled (scales with Dynamic Type), otherwise SF Pro Rounded.
    enum Fonts {
        static let largeTitle    = make(34, .black,    .largeTitle)  // "Plop", "History", "This week"
        static let timerClock    = make(68, .black,    .largeTitle).monospacedDigit()
        static let durationHero  = make(56, .black,    .largeTitle).monospacedDigit()
        static let statValue     = make(28, .black,    .title)       // stat tiles
        static let startLabel    = make(22, .black,    .title2)      // "Start"
        static let chartValue    = make(22, .black,    .title2).monospacedDigit() // "11 min"
        static let section       = make(19, .heavy,    .title3)      // "Recent"
        static let subheading    = make(17, .heavy,    .headline)    // Log sections, nav title
        static let button        = make(18, .black,    .headline)    // Save, Done
        static let buttonOutline = make(18, .heavy,    .headline)    // Pause / Resume
        static let rowDuration   = make(17, .black,    .body).monospacedDigit()
        static let link          = make(17, .bold,     .body)        // Back, Skip
        static let rowTitle      = make(16, .heavy,    .body)        // row time, chip labels, "In session"
        static let eyebrow       = make(15, .bold,     .subheadline) // date over large title
        static let groupHeader   = make(15, .heavy,    .subheadline) // "Today", "Yesterday"
        static let seeAll        = make(15, .bold,     .subheadline)
        static let insightTitle  = make(15, .heavy,    .subheadline)
        static let body          = make(15, .semibold, .subheadline) // text field
        static let hint          = make(14, .bold,     .footnote)    // hint pill
        static let segment       = make(14, .heavy,    .footnote)    // Week / Month / All
        static let insightBody   = make(14, .semibold, .footnote)
        static let rowMeta       = make(13, .semibold, .footnote)    // "Easy · type 4"
        static let tileLabel     = make(13, .bold,     .footnote)    // "Today", "Avg. time"
        static let axisLabel     = make(12, .heavy,    .caption)     // chart days, Hard/Normal/Loose
        static let tabLabel      = make(11, .heavy,    .caption2)
        
        // Letter spacing
        static let largeTitleTracking: CGFloat = -0.5
        static let clockTracking: CGFloat      = -1    // timer clock & duration hero
        
        private static func make(_ size: CGFloat, _ weight: Font.Weight, _ style: Font.TextStyle) -> Font {
            if let name = nunitoName(for: weight), UIFont(name: name, size: size) != nil {
                return .custom(name, size: size, relativeTo: style)
            }
            return .system(size: size, weight: weight, design: .rounded)
        }
        
        private static func nunitoName(for weight: Font.Weight) -> String? {
            switch weight {
            case .black:    "Nunito-Black"       // 900
            case .heavy:    "Nunito-ExtraBold"   // 800
            case .bold:     "Nunito-Bold"        // 700
            case .semibold: "Nunito-SemiBold"    // 600
            default:        nil
            }
        }
    }
    
    // MARK: Spacing
    enum Spacing {
        static let screenH: CGFloat     = 24   // screen horizontal padding
        static let screenTop: CGFloat   = 18   // content top (below status bar)
        static let homeSection: CGFloat = 22   // between Home sections
        static let logSection: CGFloat  = 24   // between Log sections
        static let listSection: CGFloat = 16   // History / Stats sections
        static let tile: CGFloat        = 12   // between tiles, between bottom buttons
        static let group: CGFloat       = 10   // within a group, between chips
        static let tight: CGFloat       = 8    // day header → card, chart bars
        static let typeChipGap: CGFloat = 6    // Bristol 1–7 chips
        static let rowH: CGFloat        = 16   // row horizontal padding
        static let rowV: CGFloat        = 14   // row vertical padding
        static let tilePadding: CGFloat = 16
    }
    
    // MARK: Radius
    enum Radius {
        static let hero: CGFloat         = 32   // Home mint card
        static let chartCard: CGFloat    = 24
        static let tile: CGFloat         = 22   // stat tiles, insight card
        static let card: CGFloat         = 20   // session cards
        static let textField: CGFloat    = 18
        static let pill: CGFloat         = 18   // hint pill
        static let chip: CGFloat         = 16
        static let segmentTrack: CGFloat = 14
        static let badge: CGFloat        = 12
        static let segment: CGFloat      = 10
        static let bar: CGFloat          = 10
    }
    
    // MARK: Sizes
    enum Size {
        static let buttonHeight: CGFloat  = 60
        static let chipHeight: CGFloat    = 52
        static let typeChip: CGFloat      = 44
        static let segmentHeight: CGFloat = 36
        static let iconButton: CGFloat    = 44
        static let badge: CGFloat         = 40
        static let startButton: CGFloat   = 188
        static let haloInner: CGFloat     = 14   // ring widths around Start
        static let haloOuter: CGFloat     = 28
        static let timerRing: CGFloat     = 280
        static let ringStroke: CGFloat    = 16
        static let chartHeight: CGFloat   = 150
        static let noteHeight: CGFloat    = 76
        static let tabBarHeight: CGFloat  = 84
    }
}

// MARK: - Hex helper

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(.sRGB,
                  red:   Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8)  & 0xFF) / 255,
                  blue:  Double( hex        & 0xFF) / 255,
                  opacity: opacity)
    }
}

enum PlopTextStyle {
    case largeTitle, eyebrow, section, subheading, groupHeader
    case rowTitle, rowMeta, rowDuration, tileLabel, statValue, chartValue
    case timerClock, durationHero, hint, link, axisLabel
    
    var font: Font {
        switch self {
        case .largeTitle:   Theme.Fonts.largeTitle
        case .eyebrow:      Theme.Fonts.eyebrow
        case .section:      Theme.Fonts.section
        case .subheading:   Theme.Fonts.subheading
        case .groupHeader:  Theme.Fonts.groupHeader
        case .rowTitle:     Theme.Fonts.rowTitle
        case .rowMeta:      Theme.Fonts.rowMeta
        case .rowDuration:  Theme.Fonts.rowDuration
        case .tileLabel:    Theme.Fonts.tileLabel
        case .statValue:    Theme.Fonts.statValue
        case .chartValue:   Theme.Fonts.chartValue
        case .timerClock:   Theme.Fonts.timerClock
        case .durationHero: Theme.Fonts.durationHero
        case .hint:         Theme.Fonts.hint
        case .link:         Theme.Fonts.link
        case .axisLabel:    Theme.Fonts.axisLabel
        }
    }
    
    var color: Color {
        switch self {
        case .eyebrow, .groupHeader, .rowMeta, .tileLabel, .axisLabel:
            Theme.Colors.textSecondary
        case .chartValue, .link:
            Theme.Colors.mintDeep
        default:
            Theme.Colors.textPrimary
        }
    }
    
    var tracking: CGFloat {
        switch self {
        case .largeTitle:                Theme.Fonts.largeTitleTracking
        case .timerClock, .durationHero: Theme.Fonts.clockTracking
        default:                         0
        }
    }
}

// MARK: - Text styles  →  Text("Plop").textStyle(.largeTitle)

extension View {
    /// Applies font, color and letter spacing in one call.
    /// Pass `color:` to override the default, e.g. `.textStyle(.rowTitle, color: Theme.Colors.mintDeep)`.
    func textStyle(_ style: PlopTextStyle, color: Color? = nil) -> some View {
        font(style.font)
            .foregroundStyle(color ?? style.color)
            .tracking(style.tracking)
    }
}

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Theme.Colors.mint
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }
}
