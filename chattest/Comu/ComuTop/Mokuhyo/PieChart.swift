//
//  PieChart.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI
import Charts

// データ構造

struct PieChart: View {
    let dataPoints: [String] = ["A", "B", "C"]
    let values: [Double] = [30, 20, 50]
    let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
        ZStack {
            ForEach(0..<dataPoints.count) { index in
                PieSlice(startAngle: angle(for: index), endAngle: angle(for: index + 1))
                    .fill(colors[index])
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ForEach(0..<dataPoints.count) { index in
                        VStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(colors[index])
                            
                            Text(dataPoints[index])
                                .font(.footnote)
                        }
                    }
                }
            }
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }
    
    private func angle(for index: Int) -> Angle {
        let totalValue = values.reduce(0, +)
        let startAngle = index == 0 ? .degrees(0) : endAngle(for: index - 1)
        let normalizedValue = values[index] / totalValue
        let endAngle = startAngle + .degrees(normalizedValue * 360)
        return endAngle
    }
    
    private func endAngle(for index: Int) -> Angle {
        if index < dataPoints.count {
            return angle(for: index)
        } else {
            return .degrees(0)
        }
    }
}


struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart()
    }
}
