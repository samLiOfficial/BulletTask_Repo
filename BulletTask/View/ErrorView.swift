//
//  ErrorView.swift
//  BulletTask
//
//  Created by sam li  on 2023-05-11.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .font(.title)
                .foregroundColor(.red)
        }
    }
}
