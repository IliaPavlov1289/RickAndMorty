//
//  CharacterDetailsInformationCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 19.11.2021.
//

import UIKit

class DetailsInformationCell: UITableViewCell {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "Gender", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    
    private(set) lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 15.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        label.attributedText = NSMutableAttributedString(string: "Male", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private(set) lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
  }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupViews() {
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.subLabel)
        self.contentView.addSubview(self.arrowImageView)
    }
    
    private func setupLayouts() {
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5),
            self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        
        self.subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.subLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor),
            self.subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5)
        ])
        
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23.0),
            self.arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 22.0),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 13.0)
        ])
    }
}

extension DetailsInformationCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

