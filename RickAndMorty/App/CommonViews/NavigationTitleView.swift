//
//  NavigationTitleView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 24.11.2021.
//

import UIKit

class NavigationTitleView: UIView {

    private(set) lazy var titleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "line")
        return imageView
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        label.attributedText = NSMutableAttributedString(string: "Species", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProText-Semibold", size: 15.0) ?? UIFont.systemFont(ofSize: 15)])
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        self.addSubview(self.titleImageView)
        self.addSubview(self.label)
    }
    
    private func setupLayouts() {
        self.titleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -2),
            self.titleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

    }

}
