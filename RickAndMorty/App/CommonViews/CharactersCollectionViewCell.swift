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
    
    private enum Constants {
        static let spacing: CGFloat = 12.0
        static let borderWidth: CGFloat = 1.0
        static let radius: CGFloat = 8.0
        
    }
    
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
        paragraphStyle.lineHeightMultiple = 0.90
        
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
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = Constants.borderWidth
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = Constants.radius
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.characterImageView)
        self.contentView.addSubview(self.statusLabel)
        self.contentView.addSubview(self.nameLabel)
    }
    
    private func setupLayouts() {
        self.characterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.characterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.statusLabel.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: Constants.spacing),
            self.statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            self.statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            self.nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.spacing)
        ])
        
    }
}

extension CharactersCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
