//
//  LocetionNameFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 25.11.2021.
//

import UIKit

class LocationNameFilterViewController: UIViewController {
    
    private var locationsFilterView: NameFilterView {
        return self.view as! NameFilterView
    }
    private var locations = [Location]()
    private var criterias = FilterCriterias.shared
    
    override func loadView() {
        super.loadView()
        self.view = NameFilterView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsFilterView.tableView.register(CharacterDetailsInformationCell.self, forCellReuseIdentifier: CharacterDetailsInformationCell.identifier)
        self.locationsFilterView.tableView.dataSource = self
        self.locationsFilterView.tableView.delegate = self
        self.locationsFilterView.searchBar.delegate = self
        
        self.locationsFilterView.tableView.sectionHeaderTopPadding = 0
        self.locationsFilterView.tableView.sectionFooterHeight = 0
        self.locationsFilterView.tableView.sectionHeaderHeight = 0
        self.locationsFilterView.searchBar.placeholder = "Enter location name"
        
        let name = self.criterias.locationsFilterCriterias[0].param
        self.locationsFilterView.searchBar.searchTextField.text = name
        
        NetworkManager.shared.getLocations(name: name, type: nil, dimension: nil) { [weak self] (locations) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.locations = locations
                self.locationsFilterView.tableView.reloadData()
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

extension LocationNameFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension LocationNameFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsInformationCell.identifier, for: indexPath) as? CharacterDetailsInformationCell {
            cell.label.text = self.locations[indexPath.row].name
            cell.subLabel.text = self.locations[indexPath.row].type

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationDetailsController = LocationDetailsController(location: self.locations[indexPath.row])
        navigationController?.pushViewController(locationDetailsController, animated: true)
    }
}

extension LocationNameFilterViewController: UISearchBarDelegate {
    
    private func setupNameParametrs(param: String?, isSelected: Bool, subtitle: String) {
        self.criterias.locationsFilterCriterias[0].param = param
        self.criterias.locationsFilterCriterias[0].isSelected = isSelected
        self.criterias.locationsFilterCriterias[0].subtitle = subtitle
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        NetworkManager.shared.getLocations(name: searchText, type: nil, dimension: nil) { [weak self] (locations) in
            guard let self = self else {return}
            self.locations = locations
            if (searchText == "") {
                self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
            } else {
                self.setupNameParametrs(param: searchText, isSelected: true, subtitle: searchText)
            }
            self.locationsFilterView.noResultsLabel.isHidden = true
            self.locationsFilterView.tableView.reloadData()
        }
        self.locations = []
        self.setupNameParametrs(param: nil, isSelected: false, subtitle: "Give a name")
        self.locationsFilterView.noResultsLabel.isHidden = false
        self.locationsFilterView.tableView.reloadData()
    }
}
