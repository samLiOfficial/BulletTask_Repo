//
//  UIComponents.swift
//  BulletTask
//
//  Created by sam li  on 2023-05-04.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(20)
            .foregroundColor(.white)
            .font(.headline)
            .padding(.leading)
            .padding(.trailing)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .background(Color.gray.opacity(0.3).cornerRadius(20))
            .foregroundColor(.black)
            .font(.headline)
            .padding(.leading)
            .padding(.trailing)
    }
}

struct ListViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 2.0)
    }
}

extension View {
    func applyButtonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
    
    func applyTextFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
    
    func applyListViewStyle() -> some View {
        self.modifier(ListViewStyle())
    }
}

