//
//  CharactersFilterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 03.11.2021.
//

import UIKit

protocol FilterScreenDelegate: AnyObject {
    func selectedParams(name: String?, status: String?, species: String?, gender: String?)
}

class CharactersFilterViewController: UIViewController {
    
    weak var delegate: FilterScreenDelegate?
    
    private var charactersFilterView: CharactersFilterView {
        return self.view as! CharactersFilterView
    }
    
    private var criterias = FilterCriterias.shared

    override func loadView() {
        super.loadView()
        self.view = CharactersFilterView()
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
        
        if (criterias.charactersFilterCriterias.flatMap({ $0.filter({ $0.isSelected == true }) }).count != 0) {
            self.navigationItem.leftBarButtonItem?.customView?.isHidden = false
        } else {
            self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        }

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        let imageView = UIImageView(frame: CGRect(x: 0, y: -5, width: 36, height: 5))
         imageView.contentMode = .scaleAspectFit
         let image = UIImage(named: "line")
         imageView.image = image
        view.addSubview(imageView)
        let title = UILabel(frame: CGRect(x: 0, y: 8, width: 36, height: 20))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        title.attributedText = NSMutableAttributedString(string: "Filter", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProText-Semibold", size: 15.0) ?? UIFont.systemFont(ofSize: 15)])
        view.addSubview(title)
         navigationItem.titleView = view

    }
    
    @objc func applyFilterCriterias() {
        
        let status = criterias.charactersFilterCriterias[2].filter({ $0.isSelected }).first?.title
        let gender = criterias.charactersFilterCriterias[3].filter({ $0.isSelected }).first?.title
        
        delegate?.selectedParams(name: nil, status: status, species: nil, gender: gender)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clearFilterCriterias() {
        var section = 0
        repeat {
            var index = 0
            repeat {
                criterias.charactersFilterCriterias[section][index].isSelected = false
                index += 1
            } while index < criterias.charactersFilterCriterias[section].count
            section += 1
        } while section < criterias.charactersFilterCriterias.count
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
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
                header.label.text = criterias.charactersFilterCriterias[section].first?.sectionName
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
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        criterias.charactersFilterCriterias[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,1:
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell {
            cell.label.text = criterias.charactersFilterCriterias[indexPath.section][indexPath.row].title
            cell.subLabel.text = criterias.charactersFilterCriterias[indexPath.section][indexPath.row].subtitle
            cell.radioImageView.image = UIImage(named: "unchecked")
            
            return cell
        }
        return UITableViewCell()
            
        case 2,3:
        if let cell = tableView.dequeueReusableCell(withIdentifier: RadioFilterCell.identifier, for: indexPath) as? RadioFilterCell {
            cell.label.text = criterias.charactersFilterCriterias[indexPath.section][indexPath.row].title
            cell.selectionStyle = .none
            cell.isSelected(criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected)

            return cell
        }
        return UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.section {
        case 2,3:
            if (criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected == false) {
                var i = 0
                repeat {
                    criterias.charactersFilterCriterias[indexPath.section][i].isSelected = false
                    i += 1
                } while i < criterias.charactersFilterCriterias[indexPath.section].count
            }
            criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected =  !criterias.charactersFilterCriterias[indexPath.section][indexPath.row].isSelected
            
            if (criterias.charactersFilterCriterias.flatMap({ $0.filter({ $0.isSelected == true }) }).count != 0) {
                self.navigationItem.leftBarButtonItem?.customView?.isHidden = false
            } else {
                self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
            }
    
            self.charactersFilterView.tableView.reloadData()
        default:
            return
        }
    
    }
    
}
