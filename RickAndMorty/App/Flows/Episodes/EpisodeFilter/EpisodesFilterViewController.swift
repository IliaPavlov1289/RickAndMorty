//
//  EpisodesFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 27.11.2021.
//

import UIKit

protocol EpisodesFilterDelegate: AnyObject {
    func selectedParams(name: String?)
}

class EpisodesFilterViewController: UIViewController {
    
    weak var delegate: EpisodesFilterDelegate?
    
    private var episodesFilterView: TableView {
        return self.view as! TableView
    }
    private var episodes = FilterCriterias.shared
    
    override func loadView() {
        super.loadView()
        self.view = TableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.episodesFilterView.tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        self.episodesFilterView.tableView.dataSource = self
        self.episodesFilterView.tableView.delegate = self
        
        self.episodesFilterView.tableView.contentInsetAdjustmentBehavior = .never
        self.episodesFilterView.tableView.sectionHeaderTopPadding = 0
        self.episodesFilterView.tableView.sectionFooterHeight = 0
        
        let rightButton = UIButton.createApplyButton()
        rightButton.addTarget(self, action: #selector(applyFilterCriterias), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        let leftButton = UIButton.createClearButton()
        leftButton.addTarget(self, action: #selector(clearFilterCriterias), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)

        let navigationTitleView = NavigationTitleView()
        navigationTitleView.label.text = "Filter"
        self.navigationItem.titleView = navigationTitleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toggleClearButton()
        self.episodesFilterView.tableView.reloadData()
    }
    
    private func toggleClearButton() {
        let hasSelectedItems = self.episodes.episodesFilterCriterias[0].isSelected 
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = hasSelectedItems ? false : true
    }
    
    @objc private func applyFilterCriterias() {
        
        let name = self.episodes.episodesFilterCriterias[0].param

        delegate?.selectedParams(name: name)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clearFilterCriterias() {
        self.episodes.episodesFilterCriterias[0].isSelected = false
        self.episodes.episodesFilterCriterias[0].param = nil

        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        self.episodes.episodesFilterCriterias[0].subtitle = "Give a name"
        self.episodesFilterView.tableView.reloadData()
    }
}

extension EpisodesFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.0
    }
}

extension EpisodesFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.episodes.episodesFilterCriterias.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.episodesFilterCriterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell {
            cell.label.text = episodes.episodesFilterCriterias[indexPath.section].title
            cell.subLabel.text = episodes.episodesFilterCriterias[indexPath.section].subtitle
            cell.selectionStyle = .none
            cell.isSelected(self.episodes.episodesFilterCriterias[indexPath.section].isSelected)
                 
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let episodesNameFilterViewController = EpisodesNameFilterViewController()
        self.navigationController?.pushViewController(episodesNameFilterViewController, animated: true)
    }
}

