//
//  LocationDimensionFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 26.11.2021.
//

import UIKit

class LocationDimensionFilterViewController: UIViewController {

    private var locationsFilterView: FilterView {
        return self.view as! FilterView
    }
    
    private var criterias = FilterCriterias.shared
    private var filterCriterias = [
        FilterCriteria(sectionName: "Type", title: "Dimension C-137", param: "Dimension C-137", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Post-Apocalyptic Dimension", param: "Post-Apocalyptic Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Replacement Dimension", param: "Replacement Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Cronenberg Dimension", param: "Cronenberg Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Dimension 5-126", param: "Dimension 5-126", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Dimension C-500A", param: "Dimension C-500A", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Dimension K-83", param: "Dimension K-83", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Eric Stoltz Mask Dimension", param: "Eric Stoltz Mask Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Fantasy Dimension", param: "Fantasy Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Testicle Monster Dimension", param: "Testicle Monster Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Merged Dimension", param: "Merged Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Cromulon Dimension", param: "Cromulon Dimension", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Type", title: "Unknown", param: "Unknown", isSelected: false, subtitle: nil)
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
        
        if (self.criterias.locationsFilterCriterias[2].isSelected) {
            self.filterCriterias.filter({$0.param == self.criterias.locationsFilterCriterias[2].param}).first?.isSelected = true
        }
    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LocationDimensionFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension LocationDimensionFilterViewController: UITableViewDataSource {
    
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
            self.criterias.locationsFilterCriterias[2].param = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
            self.criterias.locationsFilterCriterias[2].isSelected = true
            self.criterias.locationsFilterCriterias[2].subtitle = self.filterCriterias.filter({ $0.isSelected == true}).first?.param
        } else {
            self.criterias.locationsFilterCriterias[2].param = nil
            self.criterias.locationsFilterCriterias[2].isSelected = false
            self.criterias.locationsFilterCriterias[2].subtitle = "Select one"
        }
        self.locationsFilterView.tableView.reloadData()
    }
    
}
