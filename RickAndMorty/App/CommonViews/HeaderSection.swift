//
//  HeaderSection.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 20.11.2021.
//

import UIKit

class HeaderSection: UITableViewHeaderFooterView {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray1
        label.font = UIFont.init(name: "SFProDisplay-Bold", size: 20.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: " ", attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        self.contentView.addSubview(self.label)
    }
    
    private func setupLayouts() {
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            self.label.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -9.5)
        ])
    }
    
}

extension HeaderSection: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
