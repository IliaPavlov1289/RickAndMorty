//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 18.11.2021.
//

import UIKit

class CharacterDetailsView: UIView {
    
    private(set) var characterDetailsHeaderView = CharacterDetailsHeaderView()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        return tableView
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
        self.addSubview(self.characterDetailsHeaderView)
        self.addSubview(self.tableView)
    }

    func setupLayouts() {
        
        self.characterDetailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.characterDetailsHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.characterDetailsHeaderView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.characterDetailsHeaderView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
            
        ])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.characterDetailsHeaderView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}
