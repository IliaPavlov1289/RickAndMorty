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
        self.addSubview(characterDetailsHeaderView)
        self.addSubview(tableView)
    }

    func setupLayouts() {
        
        characterDetailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterDetailsHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            characterDetailsHeaderView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            characterDetailsHeaderView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
            
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: characterDetailsHeaderView.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}
