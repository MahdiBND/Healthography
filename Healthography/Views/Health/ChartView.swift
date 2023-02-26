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
		ScrollView(.horizontal) {
			HStack(alignment: .bottom) {
				ForEach(datas.sorted(by: <), id: \.key) { key, value in
					VStack {
						Text(String(format: "%.0f", value))
							.font(.caption)
							.foregroundColor(.secondary)
						RoundedRectangle(cornerRadius: 8)
							.fill(Color.indigo)
							.frame(width: 12, height: value / 20)
					}
				}
			}
		}
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
