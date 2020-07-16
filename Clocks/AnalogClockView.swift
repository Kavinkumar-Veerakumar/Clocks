//
//  ClockView.swift
//  Clocks
//
//  Created by Kavinkumar Veerakumar on 16/07/20.
//  Copyright © 2020 Kavinkumar Veerakumar. All rights reserved.
//

import SwiftUI

struct AnalogClockView: View {
    
    @Binding private var lineWidth: Double
    
    @State private var currentDate = Date()
    @State private var selectedColorIndex = 0
    @State private var randomColor = false
    private var action: (() -> Void)?
    
    init(lineWidth: Binding<Double>, action: (() -> Void)? = nil) {
        self.action = action
        self._lineWidth = lineWidth
    }
    
    private var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.action?()
            if self.randomColor {
                self.selectedColorIndex = Int.random(in: 0..<self.colors.count)
            }
            self.currentDate = Date()
        }
    }
    private var dateFromatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss"
        return formatter
    }
    private var colors: [UIColor] = [primaryColor , .black, .systemBlue, .systemGreen, .systemIndigo, .systemOrange, .systemPink, .systemPurple, .systemRed]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color(colors[selectedColorIndex]))
                            .frame(width: 250, height: 250)
                            .clipShape(Circle())
                            .shadow(radius: 32.0)
                        Clock(date: $currentDate)
                            .stroke(Color(colors[selectedColorIndex]), style: StrokeStyle(lineWidth: CGFloat(lineWidth), lineCap: .round, lineJoin: .bevel))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 200, height: 200)
                            .background(Color(secondary).clipShape(Circle()))
                        Circle()
                            .fill(Color(colors[selectedColorIndex]))
                            .frame(width:10, height: 10)
                    }
                    Text("\(currentDate, formatter: dateFromatter)")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                    Slider(value: $lineWidth, in: 1.0...5.0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<colors.count) { index in
                                Color(self.colors[index])
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(4.0)
                                    .onTapGesture {
                                        self.selectedColorIndex = index
                                }
                            }
                        }
                    }
                    Toggle(isOn: $randomColor) {
                        Text("Change color randomly")
                    }
                    
                }
                .padding(.horizontal, 30.0)
            }
        }.onAppear {
            _ = self.timer
        }
    }
}

struct AnalogClockView_Previews: PreviewProvider {
    
    static var previews: some View {
        AnalogClockView(lineWidth: .constant(1.0))
    }
}
