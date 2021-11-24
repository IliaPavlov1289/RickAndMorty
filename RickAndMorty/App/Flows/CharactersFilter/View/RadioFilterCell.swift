//
//  RadioFilterCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 04.11.2021.
//

import UIKit

class RadioFilterCell: UITableViewCell {
    
    private(set) lazy var radioImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Regular", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "Name", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
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
        self.radioImageView.image = image
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
    }
    
    private func setupLayouts() {
        self.radioImageView.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.radioImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9.5),
            self.radioImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.radioImageView.heightAnchor.constraint(equalToConstant: 30.0),
            self.radioImageView.widthAnchor.constraint(equalToConstant: 28.0)
        ])
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.5),
            self.label.leadingAnchor.constraint(equalTo: self.radioImageView.trailingAnchor, constant: 13),
            self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5)
        ])
        
    }
}

extension RadioFilterCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
