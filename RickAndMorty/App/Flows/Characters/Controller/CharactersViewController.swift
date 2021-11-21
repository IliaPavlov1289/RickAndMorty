//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//


import UIKit

class CharactersViewController: UIViewController {
    
    private var charactersView: CharactersView {
        return self.view as! CharactersView
    }
    private var button: UIButton?
    private var characters = [Character]()
    
    override func loadView() {
        super.loadView()
        self.view = CharactersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersView.collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
        self.charactersView.collectionView.dataSource = self
        self.charactersView.collectionView.delegate = self
        
        NetworkManager.shared.getCaracters(name: nil, status: nil, species: nil, gender: nil) { [weak self] (characters) in
            guard let self = self else {return}
            self.characters = characters
            self.charactersView.collectionView.reloadData()
        }

        self.button = UIButton.createFilterButton()
        self.button?.addTarget(self, action: #selector(openFilterCriterias), for: .touchUpInside)
        self.button?.imageView?.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.button ?? UIButton())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Character"
        navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProDisplay-Bold", size: 34.0) ?? UIFont.systemFont(ofSize: 34.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    
    @objc func openFilterCriterias() {
        let charactersFilterViewController = CharactersFilterViewController()
        charactersFilterViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: charactersFilterViewController)
        present(navigationController, animated: true, completion: nil)
            
    }
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as! CharactersCollectionViewCell
         
        cell.nameLabel.text = characters[indexPath.row].name
        cell.statusLabel.text = characters[indexPath.row].status

        let url = characters[indexPath.row].image
        NetworkManager.shared.getImage(fromUrl: url) { (image) in
            guard let image = image else { return }
            cell.characterImageView.image = image
        }
        return cell
        
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterDetailsController = CharacterDetailsController(character: characters[indexPath.row])
        navigationController?.pushViewController(characterDetailsController, animated: true)
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: self.view.frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: width + Constants.heightCardDescription)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

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

extension CharactersViewController: FilterScreenDelegate {
    func selectedParams(name: String?, status: String?, species: String?, gender: String?) {
        if (name != nil || status != nil || species != nil || gender != nil) {

            self.button?.imageView?.isHidden = false
        } else {
            self.button?.imageView?.isHidden = true
                }
        
        NetworkManager.shared.getCaracters(name: name, status: status, species: species, gender: gender) { [weak self] (characters) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.characters = characters
                self.charactersView.collectionView.reloadData()
            }
        }
    }
}
