//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 25.11.2021.
//

import UIKit

class LocationsViewController: UIViewController {
    
    private enum Constants {
        static let spacing: CGFloat = 16.0
        static let heightCardDescription: CGFloat = 79.0
        static let itemsInRow: CGFloat = 2.0
    }
    
    private var locationsView: CollectionView {
        return self.view as! CollectionView
    }
    private var button: UIButton?
    private var locations = [Location]()

    override func loadView() {
        super.loadView()
        self.view = CollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsView.collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
        self.locationsView.collectionView.dataSource = self
        self.locationsView.collectionView.delegate = self
        
        NetworkManager.shared.getLocations(name: nil, type: nil, dimension: nil) { [weak self] (locations) in
            guard let self = self else {return}
            self.locations = locations
            self.locationsView.collectionView.reloadData()
        }

        self.button = UIButton.createFilterButton()
        self.button?.addTarget(self, action: #selector(openFilterCriterias), for: .touchUpInside)
        self.button?.imageView?.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.button ?? UIButton())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Location"
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProDisplay-Bold", size: 34.0) ?? UIFont.systemFont(ofSize: 34.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    
    @objc private func openFilterCriterias() {
        print()
        let locationsFilterViewController = LocationsFilterViewController()
        locationsFilterViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: locationsFilterViewController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension LocationsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as! LocationCollectionViewCell
        cell.tupeLabel.text = self.locations[indexPath.row].type
        cell.nameLabel.text = self.locations[indexPath.row].name
        return cell
    }
}

extension LocationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationDetailsController = LocationDetailsController(location: self.locations[indexPath.row])
        navigationController?.pushViewController(locationDetailsController, animated: true)
    }
}
    
extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: self.view.frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: Constants.heightCardDescription)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {

        let totalSpacing: CGFloat = Constants.itemsInRow * spacing + (Constants.itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / Constants.itemsInRow

        return floor(finalWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
}

extension LocationsViewController: LocationsFilterDelegate {
    func selectedParams(name: String?, type: String?, dimension: String?) {
        let notEmptyParams = (name != nil || type != nil || dimension != nil)
        self.button?.imageView?.isHidden = notEmptyParams ? false : true
        
        NetworkManager.shared.getLocations(name: name, type: type, dimension: dimension) { [weak self] (locations) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.locations = locations
                self.locationsView.noResultsLabel.isHidden = true
                self.locationsView.collectionView.reloadData()
            }
        }
        self.locations = []
        self.locationsView.noResultsLabel.isHidden = false
        self.locationsView.collectionView.reloadData()
    }
}


