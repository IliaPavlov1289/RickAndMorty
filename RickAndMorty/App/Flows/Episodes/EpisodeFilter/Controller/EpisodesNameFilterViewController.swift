//
//  EpisodesNameFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 27.11.2021.
//

import UIKit

class EpisodesNameFilterViewController: UIViewController {

    private var episodesFilterView: NameFilterView {
        return self.view as! NameFilterView
    }
    private var episodes = [Episode]()
    private var criterias = FilterCriterias.shared
    
    override func loadView() {
        super.loadView()
        self.view = NameFilterView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesFilterView.tableView.register(DetailsInformationCell.self, forCellReuseIdentifier: DetailsInformationCell.identifier)
        self.episodesFilterView.tableView.dataSource = self
        self.episodesFilterView.tableView.delegate = self
        self.episodesFilterView.searchBar.delegate = self
        
        self.episodesFilterView.tableView.sectionHeaderTopPadding = 0
        self.episodesFilterView.tableView.sectionFooterHeight = 0
        self.episodesFilterView.tableView.sectionHeaderHeight = 0
        self.episodesFilterView.searchBar.placeholder = "Enter location name"
        
        let name = self.criterias.episodesFilterCriterias[0].param
        self.episodesFilterView.searchBar.searchTextField.text = name
        
        NetworkManager.shared.getEpisodes(name: name) { [weak self] (episodes) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.episodes = episodes
                self.episodesFilterView.tableView.reloadData()
            }
        }
        
        let navigationTitleView = NavigationTitleView()
        navigationTitleView.label.text = "Name"
        self.navigationItem.titleView = navigationTitleView
        
        let backButton = UIButton.createBackButton()
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EpisodesNameFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension EpisodesNameFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailsInformationCell.identifier, for: indexPath) as? DetailsInformationCell {
            cell.selectionStyle = .none
            cell.label.text = self.episodes[indexPath.row].name
            cell.subLabel.text = self.episodes[indexPath.row].airDate

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeDetailsController = EpisodeDetailsController(episode: self.episodes[indexPath.row])
        navigationController?.pushViewController(episodeDetailsController, animated: true)
    }
}

extension EpisodesNameFilterViewController: UISearchBarDelegate {
    
    private func setupNameParametrs(param: String?, isSelected: Bool, subtitle: String) {
        self.criterias.episodesFilterCriterias[0].param = param
        self.criterias.episodesFilterCriterias[0].isSelected = isSelected
        self.criterias.episodesFilterCriterias[0].subtitle = subtitle
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        NetworkManager.shared.getEpisodes(name: searchText) { [weak self] (episodes) in
            guard let self = self else {return}
            self.episodes = episodes
            if (searchText == "") {
                self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
            } else {
                self.setupNameParametrs(param: searchText, isSelected: true, subtitle: searchText)
            }
            self.episodesFilterView.noResultsLabel.isHidden = true
            self.episodesFilterView.tableView.reloadData()
        }
        self.episodes = []
        self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
        self.episodesFilterView.noResultsLabel.isHidden = false
        self.episodesFilterView.tableView.reloadData()
    }
}
