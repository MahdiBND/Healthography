//
//  ItemDetails.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct ItemDetails: View {
	var covidItem: CovidDataItem
	
    var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Infected: \(covidItem.cases)")
			Text("Recovered: \(covidItem.cured)")
			Text("Deaths: \(covidItem.deaths)")
		}
		.font(.title2)
		.padding()
		.navigationTitle(covidItem.country)
    }
}
