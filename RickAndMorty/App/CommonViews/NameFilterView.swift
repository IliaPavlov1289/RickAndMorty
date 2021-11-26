//
//  NameFilterView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 21.11.2021.
//

import UIKit

class NameFilterView: UIView {

    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter character name"
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        return searchBar
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private(set) lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.init(name: "SFProText-Semibold", size: 17.0)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "No results", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.isHidden = true
        return label
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
    
    private func setupViews() {
        self.addSubview(self.searchBar)
        self.addSubview(self.tableView)
        self.addSubview(self.noResultsLabel)
    }
    
    private func setupLayouts() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 36),
            self.searchBar.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 8),
            self.searchBar.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -8)
        ])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 8.5),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        self.noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.noResultsLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16.0),
            self.noResultsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
