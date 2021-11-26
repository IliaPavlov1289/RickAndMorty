//
//  CharactersFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 03.11.2021.
//

import UIKit

protocol CharactersFilterDelegate: AnyObject {
    func selectedParams(name: String?, status: String?, species: String?, gender: String?)
}

class CharactersFilterViewController: UIViewController {
    
    weak var delegate: CharactersFilterDelegate?
    
    private var charactersFilterView: FilterView {
        return self.view as! FilterView
    }
    
    private var criterias = FilterCriterias.shared

    override func loadView() {
        super.loadView()
        self.view = FilterView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersFilterView.tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        self.charactersFilterView.tableView.register(RadioFilterCell.self, forCellReuseIdentifier: RadioFilterCell.identifier)
        self.charactersFilterView.tableView.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableViewCell.identifier)
        self.charactersFilterView.tableView.dataSource = self
        self.charactersFilterView.tableView.delegate = self
        
        self.charactersFilterView.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 56, bottom: 0, right: 0)
        self.charactersFilterView.tableView.contentInsetAdjustmentBehavior = .never
        self.charactersFilterView.tableView.sectionHeaderTopPadding = 0
        self.charactersFilterView.tableView.sectionFooterHeight = 0
     
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
        self.charactersFilterView.tableView.reloadData()
    }
    
    private func toggleClearButton() {
        let hasSelectedItems = (self.criterias.charactersFilterCriterias.flatMap({ $0.filter({ $0.isSelected == true }) }).count != 0)
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = hasSelectedItems ? false : true
    }
    
    @objc private func applyFilterCriterias() {
        
        let name = self.criterias.charactersFilterCriterias[0].filter({ $0.isSelected }).first?.param
        let species = self.criterias.charactersFilterCriterias[1].filter({ $0.isSelected }).first?.param
        let status = self.criterias.charactersFilterCriterias[2].filter({ $0.isSelected }).first?.param
        let gender = self.criterias.charactersFilterCriterias[3].filter({ $0.isSelected }).first?.param
        
        delegate?.selectedParams(name: name, status: status, species: species, gender: gender)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clearFilterCriterias() {
        var section = 0
        repeat {
            var index = 0
            repeat {
                self.criterias.charactersFilterCriterias[section][index].isSelected = false
                index += 1
            } while index < self.criterias.charactersFilterCriterias[section].count
            section += 1
        } while section < self.criterias.charactersFilterCriterias.count
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        self.criterias.charactersFilterCriterias[1][0].subtitle = "Select one"
        self.criterias.charactersFilterCriterias[0][0].subtitle = "Give a name"
        self.criterias.charactersFilterCriterias[0][0].param = nil
        self.charactersFilterView.tableView.reloadData()
    }

}

extension CharactersFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0,1:
            return nil
        case 2,3:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableViewCell.identifier) as? HeaderTableViewCell {
                header.label.text = self.criterias.charactersFilterCriterias[section].first?.sectionName
                return header
            }
            return nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        case 1:
            return 19.0
        case 2:
            return 46.0
        case 3:
            return 56.0
        default:
            return 0.0
        }
    }
    
}

extension CharactersFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.criterias.charactersFilterCriterias.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.criterias.charactersFilterCriterias[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,1:
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell {
            cell.label.text = self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].title
            cell.subLabel.text = self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].subtitle
            cell.selectionStyle = .none
            cell.isSelected(self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected)
            
            return cell
        }
        return UITableViewCell()
            
        case 2,3:
        if let cell = tableView.dequeueReusableCell(withIdentifier: RadioFilterCell.identifier, for: indexPath) as? RadioFilterCell {
            cell.label.text = self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].title
            cell.selectionStyle = .none
            cell.isSelected(self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected)

            return cell
        }
        return UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.section {
        case 0:
            let characterNameFilterViewController = CharacterNameFilterViewController()
            self.navigationController?.pushViewController(characterNameFilterViewController, animated: true)
        case 1:
            let characterSpeciesFilterViewController = CharacterSpeciesFilterViewController()
            self.navigationController?.pushViewController(characterSpeciesFilterViewController, animated: true)
        case 2,3:
            if (self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected == false) {
                var i = 0
                repeat {
                    self.criterias.charactersFilterCriterias[indexPath.section][i].isSelected = false
                    i += 1
                } while i < self.criterias.charactersFilterCriterias[indexPath.section].count
            }
            self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected =  !self.criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected
            
            self.toggleClearButton()
            self.charactersFilterView.tableView.reloadData()
        default:
            return
        }
    
    }
    
}
