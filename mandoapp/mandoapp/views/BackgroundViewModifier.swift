//
//  BackgroundViewModifier.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/18/22.
//

import SwiftUI


/// A `ViewModifier` to style a `View` with a system background color
private struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
            )
    }
}


extension View {
    /// Style a `View` with a grouped system background color
    /// - Returns: A view with the applied background
    func backgroundViewModifier() -> some View {
        ModifiedContent(content: self, modifier: BackgroundViewModifier())
    }
}

