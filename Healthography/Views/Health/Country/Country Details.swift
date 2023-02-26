//
//  CountryDetails.swift
//  Healthography
//
//  Created by Mahdi BND on 2/26/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CountryDetails: View {
	var country: Country
	
    var body: some View {
		VStack {
			WebImage(url: URL(string: country.flags.png))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.cornerRadius(10)
				.padding()
			
			VStack(alignment: .leading, spacing: 20) {
				Text(country.name.common)
					.font(.title)
				
				Text("Capital: \(country.capital?[0] ?? "")")
				
				Text("Location: \(country.subregion ?? "")")
				
				Text("Timezone: \(country.timezones?[0] ?? "")")
			}
			.frame(maxWidth: .infinity)
			
			Spacer()
		}
		.navigationBarTitleDisplayMode(.inline)
    }
}
