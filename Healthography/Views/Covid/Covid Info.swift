//
//  CovidInfo.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import SwiftUI

struct CovidInfo: View {
	@StateObject private var model = CovidModel()
	
	var body: some View {
		NavigationView {
			List(model.covidData) { covidItem in
				NavigationLink(destination:
								ItemDetails(covidItem: covidItem)) {
					listItem(item: covidItem)
				}
			}
			.navigationTitle("Covid Info")
		}
		.waitable(by: model)
	}
	
	// MARK: - Variables
	
	func listItem(item: CovidDataItem) -> some View {
		VStack(alignment: .leading) {
			Text(item.country)
				.font(.title2)

			HStack(spacing: 10) {
				Text("Infected: \(item.cases)")
			}
			.font(.caption)
			.foregroundColor(.secondary)
		}
	}
}

struct CovidInfo_Previews: PreviewProvider {
    static var previews: some View {
		CovidInfo()
			.preferredColorScheme(.dark)
    }
}
