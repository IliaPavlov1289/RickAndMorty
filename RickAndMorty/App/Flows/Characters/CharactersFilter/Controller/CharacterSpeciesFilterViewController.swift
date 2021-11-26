//
//  CharacterSpeciesFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 21.11.2021.
//

import UIKit

class CharacterSpeciesFilterViewController: UIViewController {
    
    private var charactersFilterView: FilterView {
        return self.view as! FilterView
    }
    private var criterias = FilterCriterias.shared
    private var filterCriterias = [
        FilterCriteria(sectionName: "Species", title: "Human", param: "Human", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Alien", param: "Alien", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Poopybutthole", param: "Poopybutthole", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Mythological Creature", param: "Mythological Creature", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "OID", param: "OID", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Cronenberg", param: "Cronenberg", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Animal", param: "Animal", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Unknown", param: "Unknown", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Robot", param: "Robot", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Species", title: "Disease", param: "Disease", isSelected: false, subtitle: nil)
        ]
    
    override func loadView() {
        super.loadView()
        self.view = FilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersFilterView.tableView.register(RadioFilterCell.self, forCellReuseIdentifier: RadioFilterCell.identifier)
        self.charactersFilterView.tableView.dataSource = self
        self.charactersFilterView.tableView.delegate = self
        
        self.charactersFilterView.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 56, bottom: 0, right: 0)
        self.charactersFilterView.tableView.sectionHeaderTopPadding = 0
        self.charactersFilterView.tableView.sectionFooterHeight = 0
        self.charactersFilterView.tableView.sectionHeaderHeight = 0
        
        let navigationTitleView = NavigationTitleView()
        navigationTitleView.label.text = "Species"
        self.navigationItem.titleView = navigationTitleView
        
        let backButton = UIButton.createBackButton()
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        if (self.criterias.charactersFilterCriterias[1][0].isSelected) {
            self.filterCriterias.filter({$0.param == self.criterias.charactersFilterCriterias[1][0].param}).first?.isSelected = true
        }
    }

    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CharacterSpeciesFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension CharacterSpeciesFilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterCriterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RadioFilterCell.identifier, for: indexPath) as? RadioFilterCell {
            cell.label.text = self.filterCriterias[indexPath.row].title
            cell.selectionStyle = .none
            cell.isSelected(self.filterCriterias[indexPath.row].isSelected)

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if (self.filterCriterias[indexPath.row].isSelected == false) {
            var i = 0
            repeat {
                self.filterCriterias[i].isSelected = false
                i += 1
            } while i < self.filterCriterias.count
        }
        self.filterCriterias[indexPath.row].isSelected =  !self.filterCriterias[indexPath.row].isSelected
        if (self.filterCriterias.filter({ $0.isSelected == true}).count > 0) {
            self.criterias.charactersFilterCriterias[1][0].param = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
            self.criterias.charactersFilterCriterias[1][0].isSelected = true
            self.criterias.charactersFilterCriterias[1][0].subtitle = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
        } else {
            self.criterias.charactersFilterCriterias[1][0].param = nil
            self.criterias.charactersFilterCriterias[1][0].isSelected = false
            self.criterias.charactersFilterCriterias[1][0].subtitle = "Select one"
        }
        self.charactersFilterView.tableView.reloadData()
    }
    
}
