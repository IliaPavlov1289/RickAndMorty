//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class CharactersCollectionViewCell: UICollectionViewCell {
    
    private(set) lazy var characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "Summer Smith", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 11.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "Dead", attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.radius
        contentView.backgroundColor = .white

        contentView.addSubview(characterImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayouts() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Constants.spacingSmall),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacingSmall),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacingSmall),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.spacingSmall)
        ])
        
    }
}

extension CharactersCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
