//
//  CompanyLogo.swift
//  RailMapiOS
//
//  Created by Jérémie Patot on 18/09/2024.
//


import SwiftUI

struct CompanyLogo: View {
    let company: String?
    var size: CGSize?
    
    public init(_ company: String? = "Eurostar", size: CGSize? = CGSize(width: 40, height: 40)) {
        self.company = company
        self.size = size
    }
    
    var body: some View {
        if let company = company {
            Image("icon_\(company.lowercased().replacingOccurrences(of: " ", with: ""))")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size?.width, height: size?.height)
                .clipShape(Circle())
                .padding(.horizontal, 10)
        }
    }
}
