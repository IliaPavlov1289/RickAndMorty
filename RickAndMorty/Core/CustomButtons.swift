//
//  CustomButtons.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 15.11.2021.
//

import Foundation
import UIKit

extension UIButton {
    class func createFilterButton() -> UIButton {
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Filter"
        configuration.attributedTitle?.kern = 0.41
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        configuration.attributedTitle?.paragraphStyle = paragraphStyle
        configuration.attributedTitle?.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        configuration.image = UIImage(named: "circle")
        configuration.baseForegroundColor = UIColor.purple
        configuration.imagePadding = 6
        
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.imageView?.isHidden = true
        return button
    }
    
    class func createApplyButton() -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "APPLY"
        configuration.attributedTitle?.kern = -0.08
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        configuration.attributedTitle?.paragraphStyle = paragraphStyle
        configuration.attributedTitle?.font = UIFont.init(name: "SFProText-Semibold", size: 13.0)
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor.purple
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 12, bottom: 5, trailing: 12)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }
    
    class func createClearButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Clear"
        configuration.attributedTitle?.kern = -0.41
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        configuration.attributedTitle?.paragraphStyle = paragraphStyle
        configuration.attributedTitle?.font = UIFont.init(name: "SFProText-Regular", size: 17.0)
        configuration.baseForegroundColor = UIColor.purple
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }
}
    
