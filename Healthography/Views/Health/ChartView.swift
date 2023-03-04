//
//  ChartView.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct ChartView: View {
	@State var datas: [TimeInterval: Double]
	@State private var showInfo = false
	@State private var info = ""
	
	var body: some View {
		GeometryReader { geoProxy in
			ZStack(alignment: .top) {
				HStack(alignment: .bottom, spacing: 1) {
					ForEach(datas.sorted(by: <), id: \.key) { key, value in
						Button(action: { }) {
							RoundedRectangle(cornerRadius: 8)
								.fill(Color.indigo)
								.frame(width: 10, height: (value / magnitude()) * geoProxy.size.height)
						}
						.pressAction {
							let date = Date(timeIntervalSinceNow: key).formatted(date: .abbreviated, time: .omitted)
							info = String(format: "%.0f", value) + " Steps\n" + date
							showInfo = true
						} onRelease: {
							showInfo = false
						}
					}
				}
				
				if showInfo {
					Text(info)
						.padding()
						.background(.bar)
						.foregroundColor(.secondary)
						.font(.footnote)
						.cornerRadius(10)
						.padding()
				}
			}
			.frame(height: geoProxy.size.height)
		}
	}
	
	func magnitude() -> Double {
		let values = datas.map { $0.value }
		let max = values.max()!
		let min = values.min()!
		return max - min
	}
}
