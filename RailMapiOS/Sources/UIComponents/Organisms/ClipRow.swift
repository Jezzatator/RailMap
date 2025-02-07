//
//  ClippedRow.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 15/11/2024.
//

import SwiftUI

struct ClippedRow: View {
    var header: String?
    var title: String?
    var bodyTexts: [String?]? = nil
    var icon: String?
    var displayMode: DisplayMode = .medium
    var content: (() -> AnyView)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if header != nil {
                headerView
            }
            contentView(for: displayMode)
            
            if let content = content {
                content()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.5)
                .shadow(color: .gray, radius: 2, x: 2, y: 2)
        )

    }
    
    // MARK: - Header View
    @ViewBuilder
    private var headerView: some View {
        Text(header!)
            .fontWeight(.semibold)
            .font(.headline)
        Divider()
    }
    
    // MARK: - Content View
    @ViewBuilder
    private func contentView(for mode: DisplayMode) -> some View {
        switch mode {
        case .small:
            smallContentView
        case .medium:
            mediumContentView
        case .large:
            mediumContentView
        }
    }
    
    // MARK: - Small Content View
    private var smallContentView: some View {
        HStack {
            VStack(alignment: .leading) {
                if icon != nil {
                    iconView(for: .small)
                }
                
                if let title = title {
                    Text(title)
                        .font(.body)
                        .fontWeight(.semibold)
                }
                
                if let bodyTexts = bodyTexts {
                    ForEach(bodyTexts.compactMap { $0 }, id: \.self) { text in
                        Text(text)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            Spacer()
        }
    }
    
    // MARK: - Medium Content View
    private var mediumContentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                if icon != nil {
                    iconView(for: .medium)
                }
                VStack(alignment: .leading) {
                    if let title = title {
                        Text(title)
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    
                    if let bodyTexts = bodyTexts {
                        ForEach(bodyTexts.compactMap { $0 }, id: \.self) { text in
                            Text(text)
                                .font(.body)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    // MARK: - Icon View

    
    private func iconView(for mode: DisplayMode) -> some View {
        let size: CGFloat
        let padding: CGFloat
        
        switch mode {
        case .small:
            size = 30
            padding = 0
        case .medium:
            size = 45
            padding = 10
        case .large:
            size = 60
            padding = 12
        }
        
        if let icon = icon {
            return AnyView(Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .padding(.horizontal, padding))
        } else {
            return AnyView(EmptyView())
        }
    }

}



// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 16) {
            ClippedRow(
                title: "Booking Code",
                bodyTexts: ["Tap to Edit"],
                icon: "ticket.fill",
                displayMode: .small
            )
            
            ClippedRow(
                title: "Seat",
                bodyTexts: ["Tap to Edit"],
                icon: "carseat.right.fill",
                displayMode: .small
            )
        }
        ClippedRow(
            header: "Medium Mode",
            title: "Prévision à l'arrivée",
            bodyTexts: ["11°C et ensoleillé"],
            icon: "cloud.sun.fill",
            displayMode: .medium
        )
        
        ClippedRow(
            content: {
                AnyView(
                    HStack {
                        Image(systemName: "clock")
                        Image(systemName: "clock")
                        Image(systemName: "clock")
                    }
                )
            }
        )
    }
}

// MARK: - DisplayMode Enum
enum DisplayMode {
    case small, medium, large
}
