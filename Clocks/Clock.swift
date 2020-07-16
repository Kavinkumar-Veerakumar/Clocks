//
//  Clock.swift
//  Clocks
//
//  Created by Kavinkumar Veerakumar on 16/07/20.
//  Copyright © 2020 Kavinkumar Veerakumar. All rights reserved.
//

import SwiftUI

struct Clock: Shape {
    
    @Binding var date: Date
    
    func path(in rect: CGRect) -> Path {
        
        let radius = min(rect.height, rect.width) * 0.5
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        
        var path = Path()
        
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        
        path.addPath(secondsLinePath(rect: rect))
        
        path.addPath(Circle().path(in: rect))
        
        path.move(to: center)
        
        let components = Calendar.current.dateComponents([.second, .minute, .hour], from: date)
        
        let secondsX = center.x + (radius * 0.6)  * cos(CGFloat(components.second ?? 0) * 6 * CGFloat.pi / 180)
        let secondsY = center.x + (radius * 0.6) * sin(CGFloat(components.second ?? 0) * 6 * CGFloat.pi / 180)
        
        path.addLine(to: CGPoint(x: secondsX, y: secondsY))
        
        let minuteX = center.x + (radius * 0.8)  * cos(CGFloat(components.minute ?? 0) * 6 * CGFloat.pi / 180)
        let minuteY = center.x + (radius * 0.8) * sin(CGFloat(components.minute ?? 0) * 6 * CGFloat.pi / 180)
        path.move(to: center)
        path.addLine(to: CGPoint(x: minuteX, y: minuteY))
        
        let hourX = center.x + (radius * 0.45)  * cos((CGFloat(components.hour ?? 0) * 30 + CGFloat(components.minute ?? 0) * 0.5) * CGFloat.pi / 180)
        let hourY = center.x + (radius * 0.45) * sin((CGFloat(components.hour ?? 0) * 30 + CGFloat(components.minute ?? 0) * 0.5 ) * CGFloat.pi / 180)
        path.move(to: center)
        path.addLine(to: CGPoint(x: hourX, y: hourY))
        
        return path
    }
    
    func secondsLinePath(rect: CGRect) -> Path {
        let radius = min(rect.height, rect.width) * 0.5
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        var angle: CGFloat = 0
        path.move(to: center)
        while angle < 360 {
            
            let x = center.x + radius  * cos(angle * CGFloat.pi / 180)
            let y = center.x + radius * sin(angle * CGFloat.pi / 180)
            
            
            let x1 = center.x + (radius - (angle.truncatingRemainder(dividingBy: 5) == 0 ? 25 : 10)) * cos(angle * CGFloat.pi / 180)
            let y1 = center.x + (radius - (angle.truncatingRemainder(dividingBy: 5) == 0 ? 25 : 10)) * sin(angle * CGFloat.pi / 180)
            
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x1, y: y1))
            path.move(to: center)
            angle += 6
        }
        return path
    }
    
}
