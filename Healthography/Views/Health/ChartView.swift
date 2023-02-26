//
//  ChartView.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct ChartView: View {
	@State var datas: [String: Double]
	@State private var showInfo = false
	
	var body: some View {
		GeometryReader { geoProxy in
			HStack(alignment: .bottom, spacing: 1) {
				ForEach(datas.sorted(by: <), id: \.key) { key, value in
					RoundedRectangle(cornerRadius: 8)
						.fill(Color.indigo)
						.frame(width: 10, height: (value / magnitude()) * geoProxy.size.height)
				}
			}
		}
	}
	
	func magnitude() -> Double {
		let values = datas.map { $0.value }
		let max = values.max()!
		let min = values.min()!
		return max - min
	}
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
