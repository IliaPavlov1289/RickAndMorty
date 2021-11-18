//
//  HeaderTableViewCell.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 07.11.2021.
//

import UIKit

class HeaderTableViewCell: UITableViewHeaderFooterView {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "SFProText-Regular", size: 15.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(string: " ", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.addSubview(label)
    }
    
    private func setupLayouts() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8.5)
        ])
    }
    
}

extension HeaderTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
