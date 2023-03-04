//
//  Extensions.swift
//  Healthography
//
//  Created by Mahdi BND on 2/25/23.
//

import SwiftUI

// MARK: - Tools
protocol Waitable {
	var waiting: Bool { get set }
}

@propertyWrapper
struct Unknown: Codable, Hashable {
	
	var wrappedValue: String?
	
	enum CodingKeys: CodingKey {}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let string = try? container.decode(String.self) {
			wrappedValue = string
		} else if let integer = try? container.decode(Int.self) {
			wrappedValue = "\(integer)"
		} else if let double = try? container.decode(Double.self) {
			wrappedValue = "\(double)"
		} else if container.decodeNil() {
			wrappedValue = nil
		}
		else {
			throw DecodingError.typeMismatch(String.self, .init(codingPath: container.codingPath, debugDescription: "Could not decode incoming value to String. It is not a type of String, Int or Double."))
		}
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(wrappedValue)
	}
	
	init() {
		self.wrappedValue = nil
	}
}


struct PressActions: ViewModifier {
	var onPress: () -> Void
	var onRelease: () -> Void
	
	func body(content: Content) -> some View {
		content
			.simultaneousGesture(
				DragGesture(minimumDistance: 0)
					.onChanged({ _ in
						onPress()
					})
					.onEnded({ _ in
						onRelease()
					})
			)
	}
}


// MARK: - Extensions
extension View {
	func waitable(by model: Waitable) -> some View {
		Group {
			if model.waiting {
				GeometryReader { proxy in
					ProgressView()
						.progressViewStyle(.circular)
						.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
				}
			} else {
				self
			}
		}
	}
	
	func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
			modifier(PressActions(onPress: {
				onPress()
			}, onRelease: {
				onRelease()
			}))
		}
}
