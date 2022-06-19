//
//  NSMutableAttributedString+appendWith.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 18.06.2022.
//

import UIKit

extension NSMutableAttributedString {

    @discardableResult func appendWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 16.0, _ text: String) -> NSMutableAttributedString{
        let attrText = NSAttributedString.makeWith(color: color, weight: weight, ofSize:ofSize, text)
        self.append(attrText)
        return self
    }
}

extension NSAttributedString {

    public static func makeWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 13.0, _ text: String) -> NSMutableAttributedString {

        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ofSize, weight: weight), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes:attrs)
    }
}
