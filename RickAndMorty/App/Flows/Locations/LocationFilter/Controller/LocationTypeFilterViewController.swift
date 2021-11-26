//
//  LocationTypeFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 26.11.2021.
//

import UIKit

class LocationTypeFilterViewController: UIViewController {
    
    private var locationsFilterView: FilterView {
        return self.view as! FilterView
    }
    
    private var criterias = FilterCriterias.shared
    private var filterCriterias = [
        FilterCriteria(sectionName: "Type", title: "Planet", param: "Planet", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Cluster", param: "Cluster", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Space station", param: "Space station", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "TV", param: "TV", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Resort", param: "Resort", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Fantasy town", param: "Fantasy town", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Dream", param: "Dream", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Menagerie", param: "Menagerie", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Diegesis", param: "Diegesis", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Elemental Rings", param: "Elemental Rings", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Consciousness", param: "Consciousness", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Memory", param: "Memory", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Nightmare", param: "Nightmare", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Daycare", param: "Daycare", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Dimension", param: "Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Unknown", param: "Unknown", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Microverse", param: "Microverse", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Customs", param: "Customs", isSelected: false, subtitle: nil)
        ]

    override func loadView() {
        super.loadView()
        self.view = FilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsFilterView.tableView.register(RadioFilterCell.self, forCellReuseIdentifier: RadioFilterCell.identifier)
        self.locationsFilterView.tableView.dataSource = self
        self.locationsFilterView.tableView.delegate = self
        
        self.locationsFilterView.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 56, bottom: 0, right: 0)
        self.locationsFilterView.tableView.sectionHeaderTopPadding = 0
        self.locationsFilterView.tableView.sectionFooterHeight = 0
        self.locationsFilterView.tableView.sectionHeaderHeight = 0

        let navigationTitleView = NavigationTitleView()
        navigationTitleView.label.text = "Type"
        self.navigationItem.titleView = navigationTitleView
        
        let backButton = UIButton.createBackButton()
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        if (self.criterias.locationsFilterCriterias[1].isSelected) {
            self.filterCriterias.filter({$0.param == self.criterias.locationsFilterCriterias[1].param}).first?.isSelected = true
        }
    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LocationTypeFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension LocationTypeFilterViewController: UITableViewDataSource {
    
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
            self.filterCriterias.forEach({ $0.isSelected = false })
        }
        self.filterCriterias[indexPath.row].isSelected =  !self.filterCriterias[indexPath.row].isSelected
        if (self.filterCriterias.filter({ $0.isSelected == true}).count > 0) {
            self.criterias.locationsFilterCriterias[1].param = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
            self.criterias.locationsFilterCriterias[1].isSelected = true
            self.criterias.locationsFilterCriterias[1].subtitle = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
        } else {
            self.criterias.locationsFilterCriterias[1].param = nil
            self.criterias.locationsFilterCriterias[1].isSelected = false
            self.criterias.locationsFilterCriterias[1].subtitle = "Select one"
        }
        self.locationsFilterView.tableView.reloadData()
    }
    
}
