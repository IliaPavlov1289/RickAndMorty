//
//  LocationDetailsHeaderView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 26.11.2021.
//

import UIKit

class LocationDetailsHeaderView: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
    }

    private(set) lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 11.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "Alive", attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProDisplay-Bold", size: 28.0)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        
        label.attributedText = NSMutableAttributedString(string: "Rick Sanchez", attributes: [NSAttributedString.Key.kern: 0.34, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var dimensionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray1
        label.font = UIFont.init(name: "SFProText-Semibold", size: 13.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        
        label.attributedText = NSMutableAttributedString(string: "HUMAN", attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray6
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        self.addSubview(self.typeLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dimensionLabel)
    }

    func setupLayouts() {
        
        self.typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.typeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing),
            self.typeLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Constants.spacing),
            self.typeLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Constants.spacing)
        ])
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor),
            self.nameLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Constants.spacing),
            self.nameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Constants.spacing)
        ])
        
        self.dimensionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.dimensionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.dimensionLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Constants.spacing),
            self.dimensionLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -Constants.spacing),
            self.dimensionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.spacing)
        ])
    }

}
