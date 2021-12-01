//
//  FilterCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 03.11.2021.
//

import UIKit

class FilterCell: UITableViewCell {
    
    private(set) lazy var radioImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "Name", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    
    private(set) lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Regular", size: 15.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        label.attributedText = NSMutableAttributedString(string: "Give a name", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    private let checked = UIImage(named: "checked")
    private let unchecked = UIImage(named: "unchecked")

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
    
    public func isSelected(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = selected ? checked : unchecked
        radioImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupViews() {
        self.contentView.addSubview(self.radioImageView)
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.subLabel)
        self.contentView.addSubview(self.arrowImageView)
    }
    
    private func setupLayouts() {
        self.radioImageView.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.subLabel.translatesAutoresizingMaskIntoConstraints = false
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.radioImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.5),
            self.radioImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.radioImageView.heightAnchor.constraint(equalToConstant: 30.0),
            self.radioImageView.widthAnchor.constraint(equalToConstant: 28.0)
        ])
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5),
            self.label.leadingAnchor.constraint(equalTo: self.radioImageView.trailingAnchor, constant: 13),
        ])
        
        NSLayoutConstraint.activate([
            self.subLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor),
            self.subLabel.leadingAnchor.constraint(equalTo: self.radioImageView.trailingAnchor, constant: 13),
            self.subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5)
        ])
        
        NSLayoutConstraint.activate([
            self.arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            self.arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 22.0),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 13.0)
        ])
        
    }
}

extension FilterCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
