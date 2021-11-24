//
//  CharacterDetailsController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 18.11.2021.
//

import UIKit

class CharacterDetailsController: UIViewController {
    
    private var characterDetailsView: CharacterDetailsView {
        return self.view as! CharacterDetailsView
    }
    
    private var character: Character
    private var episodes = [Episode]()
    
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = CharacterDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCharacterDetailsHeaderView()
        self.characterDetailsView.tableView.register(CharacterDetailsInformationCell.self, forCellReuseIdentifier: CharacterDetailsInformationCell.identifier)
        self.characterDetailsView.tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        self.characterDetailsView.tableView.register(HeaderSection.self, forHeaderFooterViewReuseIdentifier: HeaderSection.identifier)
        self.characterDetailsView.tableView.delegate = self
        self.characterDetailsView.tableView.dataSource = self
        self.characterDetailsView.tableView.sectionHeaderTopPadding = 0
        self.characterDetailsView.tableView.sectionFooterHeight = 0

        self.createNavigationTitle()
        self.setupBakcButton()
        self.getEpisodes()
    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createNavigationTitle(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = character.name
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProText-Semibold", size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func setupBakcButton() {
        let backButton = UIButton.createBackButton()
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func getEpisodes() {
        self.character.episode.forEach({ NetworkManager.shared.getEpisode(url: $0) { [weak self] (episode) in
            guard let self = self else {return}
            self.episodes.append(episode)
            self.characterDetailsView.tableView.reloadData()
        }})
    }
    
    private func createCharacterDetailsHeaderView() {
        
        self.characterDetailsView.characterDetailsHeaderView.statusLabel.text = character.status
        self.characterDetailsView.characterDetailsHeaderView.nameLabel.text = character.name
        self.characterDetailsView.characterDetailsHeaderView.speciesLabel.text = character.species.uppercased()
        
        let url = character.image
        NetworkManager.shared.getImage(fromUrl: url) { (image) in
            guard let image = image else { return }
            self.characterDetailsView.characterDetailsHeaderView.avatarImage.image = image
            
        }
        
    }
    
}

extension CharacterDetailsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSection.identifier) as? HeaderSection {
            switch section {
            case 0:
                header.label.text = "Informations"
            case 1:
                header.label.text = "Episodes"
            default:
                return nil
            }
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 51.5
        case 1:
            return 74.0
        default:
            return 0.0
        }
    }
    
}

extension CharacterDetailsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return self.episodes.count
        default:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsInformationCell.identifier, for: indexPath) as? CharacterDetailsInformationCell {
                cell.arrowImageView.isHidden = true
                switch indexPath.row {
                case 0:
                    cell.label.text = "Gender"
                    cell.subLabel.text = self.character.gender
                case 1:
                    cell.label.text = "Origin"
                    cell.subLabel.text = self.character.origin.name
                case 2:
                    cell.label.text = "Type"
                    cell.subLabel.text = self.character.type == "" ? "unspecified" : self.character.type
                case 3:
                    cell.label.text = "Location"
                    cell.subLabel.text = self.character.location.name
                    cell.arrowImageView.isHidden = false
                default:
                    break
                }
                return cell
            }
            return UITableViewCell()
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell {
                
                cell.label.text = self.episodes[indexPath.row].episode
                cell.subLabel.text = self.episodes[indexPath.row].name
                cell.dateLabel.text = self.episodes[indexPath.row].airDate.uppercased()
  
                return cell

        }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    
}
