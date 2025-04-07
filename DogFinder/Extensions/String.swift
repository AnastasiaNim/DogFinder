//
//  String .swift
//  DogFinder
//
//  Created by Anastasia N.  on 02.04.2025.
//

import Foundation
import SwiftUI


    
extension String {
    func attributed(highlights: [String],
                    color: Color = .accentColor,
                    font: Font = .headline) -> AttributedString {
        
        var attributedString = AttributedString(self)
        
        for substring in highlights {
            if let range = attributedString.range(of: substring) {
                attributedString[range].foregroundColor = color
                attributedString[range].font = font
            }
        }
        
        return attributedString
    }
    
    
    var firstDigit: String {
        String(self.split(separator: "-").first ?? "")
    }
}
    



