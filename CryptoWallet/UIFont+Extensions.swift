//
//  UIFont+Extensions.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import UIKit

extension UIFont {
    static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func poppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
