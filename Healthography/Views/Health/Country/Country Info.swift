//
//  CountryInfo.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct CountryInfo: View {
	@StateObject var model = CountryModel()
	@State var sort = Sort.name
	
	var body: some View {
		List(model.sortedCountries(by: sort), id: \.name.common) { country in
			NavigationLink(destination: CountryDetails(country: country)) {
				Text(country.name.common)
					.font(.title2)
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Menu {
					Picker("Sort", selection: $sort) {
						Text("Name").tag(0).tag(Sort.name)
						Text("Area").tag(1).tag(Sort.area)
					}
					
				} label: {
					Image(systemName: "slider.horizontal.3")
				}

				
			}
		}
		.navigationTitle("Countries")
		.waitable(by: model)
	}
}

struct CountryInfo_Previews: PreviewProvider {
    static var previews: some View {
        CountryInfo()
    }
}
