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
            return self
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        return attributedString.string
    }
}
