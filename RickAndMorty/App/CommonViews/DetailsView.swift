//
//  LocationDetailsView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 26.11.2021.
//

import UIKit

class DetailsView: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        static let smallSpacing: CGFloat = 16.0
    }

    private(set) var locationDetailsHeaderView = DetailsHeaderView()
        
    private(set) lazy var residentslabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray1
        label.font = UIFont.init(name: "SFProDisplay-Bold", size: 20.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "Residents", attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        self.addSubview(self.locationDetailsHeaderView)
        self.addSubview(self.residentslabel)
        self.addSubview(self.collectionView)
    }

    func setupLayouts() {
        
        self.locationDetailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.locationDetailsHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.locationDetailsHeaderView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.locationDetailsHeaderView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
        
        self.residentslabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.residentslabel.topAnchor.constraint(equalTo: self.locationDetailsHeaderView.bottomAnchor, constant: Constants.spacing),
            self.residentslabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: Constants.smallSpacing)
        ])
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.residentslabel.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
