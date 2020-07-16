//
//  ContentView.swift
//  Clocks
//
//  Created by Kavinkumar Veerakumar on 16/07/20.
//  Copyright © 2020 Kavinkumar Veerakumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var lineWidth = 1.0
    
    var body: some View {
        AnalogClockView(lineWidth: $lineWidth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
