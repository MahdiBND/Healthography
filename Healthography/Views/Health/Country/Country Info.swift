//
//  CountryInfo.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI

struct CountryInfo: View {
	@StateObject var model = CountryModel()
	
	var body: some View {
		List(model.countries) { country in
			NavigationLink(destination: CountryDetails(country: country)) {
				Text(country.name.common)
					.font(.title2)
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
