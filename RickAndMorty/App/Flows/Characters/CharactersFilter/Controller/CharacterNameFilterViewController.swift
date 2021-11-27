//
//  CharacterNameFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 21.11.2021.
//

import UIKit

class CharacterNameFilterViewController: UIViewController {
    
    private var charactersFilterView: NameFilterView {
        return self.view as! NameFilterView
    }
    private var characters = [Character]()
    private var criterias = FilterCriterias.shared
    
    override func loadView() {
        super.loadView()
        self.view = NameFilterView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersFilterView.tableView.register(DetailsInformationCell.self, forCellReuseIdentifier: DetailsInformationCell.identifier)
        self.charactersFilterView.tableView.dataSource = self
        self.charactersFilterView.tableView.delegate = self
        self.charactersFilterView.searchBar.delegate = self
        
        self.charactersFilterView.tableView.sectionHeaderTopPadding = 0
        self.charactersFilterView.tableView.sectionFooterHeight = 0
        self.charactersFilterView.tableView.sectionHeaderHeight = 0
        
        let name = self.criterias.charactersFilterCriterias[0][0].param
        self.charactersFilterView.searchBar.searchTextField.text = name
        
        NetworkManager.shared.getCaracters(name: name, status: nil, species: nil, gender: nil) { [weak self] (characters) in
            guard let self = self else {return}
            self.characters = characters
            self.charactersFilterView.tableView.reloadData()
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

extension CharacterNameFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension CharacterNameFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailsInformationCell.identifier, for: indexPath) as? DetailsInformationCell {
            cell.label.text = self.characters[indexPath.row].name
            cell.subLabel.text = self.characters[indexPath.row].status

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsController = CharacterDetailsController(character: self.characters[indexPath.row])
        self.navigationController?.pushViewController(characterDetailsController, animated: true)
    }
}

extension CharacterNameFilterViewController: UISearchBarDelegate {
    
    private func setupNameParametrs(param: String?, isSelected: Bool, subtitle: String) {
        self.criterias.charactersFilterCriterias[0][0].param = param
        self.criterias.charactersFilterCriterias[0][0].isSelected = isSelected
        self.criterias.charactersFilterCriterias[0][0].subtitle = subtitle
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        NetworkManager.shared.getCaracters(name: searchText, status: nil, species: nil, gender: nil) { [weak self] (characters) in
            guard let self = self else {return}
            self.characters = characters
            if (searchText == "") {
                self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
            } else {
                self.setupNameParametrs(param: searchText, isSelected: true, subtitle: searchText)
            }
            self.charactersFilterView.noResultsLabel.isHidden = true
            self.charactersFilterView.tableView.reloadData()
        }
        self.characters = []
        self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
        self.charactersFilterView.noResultsLabel.isHidden = false
        self.charactersFilterView.tableView.reloadData()
    }
}
