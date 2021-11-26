//
//  LocationsFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 25.11.2021.
//

import UIKit

protocol LocationsFilterDelegate: AnyObject {
    func selectedParams(name: String?, type: String?, dimension: String?)
}

class LocationsFilterViewController: UIViewController {
    
    weak var delegate: LocationsFilterDelegate?
    
    private var locationsFilterView: FilterView {
        return self.view as! FilterView
    }
    private var locations = FilterCriterias.shared

    override func loadView() {
        super.loadView()
        self.view = FilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationsFilterView.tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        self.locationsFilterView.tableView.dataSource = self
        self.locationsFilterView.tableView.delegate = self
        
        self.locationsFilterView.tableView.contentInsetAdjustmentBehavior = .never
        self.locationsFilterView.tableView.sectionHeaderTopPadding = 0
        self.locationsFilterView.tableView.sectionFooterHeight = 0
        
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
        self.locationsFilterView.tableView.reloadData()
    }
    
    private func toggleClearButton() {
        let hasSelectedItems = self.locations.locationsFilterCriterias.filter({ $0.isSelected == true }).count != 0
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = hasSelectedItems ? false : true
    }
    
    @objc private func applyFilterCriterias() {
        
        let name = self.locations.locationsFilterCriterias[0].param
        let type = self.locations.locationsFilterCriterias[1].param
        let dimension = self.locations.locationsFilterCriterias[2].param

        delegate?.selectedParams(name: name, type: type, dimension: dimension)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clearFilterCriterias() {
        self.locations.locationsFilterCriterias.forEach({ $0.isSelected = false })
        self.locations.locationsFilterCriterias.forEach({ $0.param = nil })

        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        self.locations.locationsFilterCriterias[0].subtitle = "Give a name"
        self.locations.locationsFilterCriterias[1].subtitle = "Select one"
        self.locations.locationsFilterCriterias[2].subtitle = "Select one"
        self.locationsFilterView.tableView.reloadData()
    }
}

extension LocationsFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        case 1,2:
            return 19.0
        default:
            return 0.0
        }
    }
}

extension LocationsFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.locations.locationsFilterCriterias.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell {
            cell.label.text = locations.locationsFilterCriterias[indexPath.section].title
            cell.subLabel.text = locations.locationsFilterCriterias[indexPath.section].subtitle
            cell.selectionStyle = .none
            cell.isSelected(self.locations.locationsFilterCriterias[indexPath.section].isSelected)
                 
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.section {
        case 0:
            let locetionNameFilterViewController = LocationNameFilterViewController()
            self.navigationController?.pushViewController(locetionNameFilterViewController, animated: true)
        case 1:
            let locationTypeFilterViewController = LocationTypeFilterViewController()
            self.navigationController?.pushViewController(locationTypeFilterViewController, animated: true)
        case 2:
            let locationDimensionFilterViewController = LocationDimensionFilterViewController()
            self.navigationController?.pushViewController(locationDimensionFilterViewController, animated: true)
        default:
            return
        }
    }
}
