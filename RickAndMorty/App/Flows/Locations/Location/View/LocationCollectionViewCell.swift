//
//  LocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 25.11.2021.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let spacing: CGFloat = 12.0
        static let borderWidth: CGFloat = 1.0
        static let radius: CGFloat = 8.0

    }
    
    private(set) lazy var tupeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 11.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "Dead", attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90
        
        label.attributedText = NSMutableAttributedString(string: "Summer Smith", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = Constants.borderWidth
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = Constants.radius
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.tupeLabel)
        self.contentView.addSubview(self.nameLabel)
    }
    
    private func setupLayouts() {
        
        self.tupeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tupeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            self.tupeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
//            self.tupeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            self.tupeLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.tupeLabel.bottomAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            self.nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
//            self.nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing)
        ])
        
    }
}

extension LocationCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
