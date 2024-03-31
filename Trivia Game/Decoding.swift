//
//  Decoding.swift
//  Trivia Game
//
//  Created by Bender on 3/30/24.
//

import Foundation

extension String {
    func decodingHTMLEntities() -> String {
        guard let data = data(using: .utf8) else {
            print("Failed to convert string to data")
            return self
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("HTML decoding error:", error)
            return self
        }
    }
}
