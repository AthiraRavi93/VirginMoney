//
//  Utilities.swift
//  VirginMoney
//
//  Created by Athira Ravi on 09/10/2022.
//

import Foundation
import UIKit
public class Utilities{
    public func setRadiusFor(view: UIView, backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
}
