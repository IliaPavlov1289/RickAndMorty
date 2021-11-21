//
//  CharacterDetailsHeaderView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 18.11.2021.
//

import UIKit

class CharacterDetailsHeaderView: UIView {

    private(set) lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .cyan
        imageView.image = UIImage(named: "characterBackground")
        return imageView
    }()
    
    private(set) lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .cyan
        imageView.layer.borderColor = UIColor.gray6.cgColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 13.0)
        
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
    
    private(set) lazy var speciesLabel: UILabel = {
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
        self.addSubview(backgroundImage)
        self.addSubview(avatarImage)
        self.addSubview(statusLabel)
        self.addSubview(nameLabel)
        self.addSubview(speciesLabel)
    }

    func setupLayouts() {
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 19.0),
            avatarImage.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: -70.0),
            avatarImage.heightAnchor.constraint(equalToConstant: 140.0),
            avatarImage.widthAnchor.constraint(equalToConstant: 140.0)
        ])
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15.0),
            statusLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
//            statusLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
            
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
            
        ])
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            speciesLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            speciesLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            speciesLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }


}
