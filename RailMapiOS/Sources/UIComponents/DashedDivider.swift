//
//  DashedDivider.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//

import SwiftUI

public struct DashedDivider: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

