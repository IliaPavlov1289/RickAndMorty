//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 26.11.2021.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    private var episodesView: TableView {
        return self.view as! TableView
    }
    private var button: UIButton?
    private var episodes = [Episode]()
    
    override func loadView() {
        super.loadView()
        self.view = TableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesView.tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        self.episodesView.tableView.register(HeaderSection.self, forHeaderFooterViewReuseIdentifier: HeaderSection.identifier)
        self.episodesView.tableView.delegate = self
        self.episodesView.tableView.dataSource = self
        
        self.episodesView.tableView.sectionHeaderTopPadding = 0
        self.episodesView.tableView.sectionFooterHeight = 0
        
        self.getEpisodes()
        self.setupFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Episode"
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProDisplay-Bold", size: 34.0) ?? UIFont.systemFont(ofSize: 34.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
        
    private func getEpisodes(){
        NetworkManager.shared.getEpisodes(name: nil) { [weak self] (episodes) in
            guard let self = self else {return}
            self.episodes = episodes
            self.episodesView.tableView.reloadData()
        }
    }
    
    private func setupFilterButton() {
        self.button = UIButton.createFilterButton()
        self.button?.addTarget(self, action: #selector(openFilterCriterias), for: .touchUpInside)
        self.button?.imageView?.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.button ?? UIButton())
    }
    
    @objc private func openFilterCriterias() {
        print()
//        let locationsFilterViewController = LocationsFilterViewController()
//        locationsFilterViewController.delegate = self
//        let navigationController = UINavigationController(rootViewController: locationsFilterViewController)
//        present(navigationController, animated: true, completion: nil)
    }
}

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSection.identifier) as? HeaderSection {
            header.label.text = "Season \(section + 1)"
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 54.5
        default:
            return 74.0
        }
    }
}

extension EpisodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var countSeasons = 0
        var prevSeason = ""
        self.episodes.forEach({
            if (String($0.episode.dropLast(3)) != prevSeason) {
                prevSeason = String($0.episode.dropLast(3))
                countSeasons += 1
            }
        })
        return countSeasons
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.filter({ $0.episode.contains("S0\(section + 1)") }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell {
            let seasonEpisodes = self.episodes.filter({ $0.episode.contains("S0\(indexPath.section + 1)") })
            
            cell.label.text = seasonEpisodes[indexPath.row].episode
            cell.subLabel.text = seasonEpisodes[indexPath.row].name
            cell.dateLabel.text = seasonEpisodes[indexPath.row].airDate.uppercased()

            return cell
    }
        return UITableViewCell()
    }
}
