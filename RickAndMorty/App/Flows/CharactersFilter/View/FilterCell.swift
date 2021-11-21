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
        self.contentView.addSubview(radioImageView)
        self.contentView.addSubview(label)
        self.contentView.addSubview(subLabel)
        self.contentView.addSubview(arrowImageView)
    }
    
    private func setupLayouts() {
        radioImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.5),
            radioImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            radioImageView.heightAnchor.constraint(equalToConstant: 30.0),
            radioImageView.widthAnchor.constraint(equalToConstant: 28.0)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5),
            label.leadingAnchor.constraint(equalTo: radioImageView.trailingAnchor, constant: 13),
        ])
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: radioImageView.trailingAnchor, constant: 13),
            subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0),
            arrowImageView.heightAnchor.constraint(equalToConstant: 22.0),
            arrowImageView.widthAnchor.constraint(equalToConstant: 13.0)
        ])
        
    }
}

extension FilterCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
