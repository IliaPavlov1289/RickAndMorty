//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//


import UIKit

class CharacterViewController: UIViewController {
    
    private var characterView: CharacterView {
        return self.view as! CharacterView
    }
    private var characters = [Character]()
    
    override func loadView() {
        super.loadView()
        self.view = CharacterView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterView.collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        self.characterView.collectionView.dataSource = self
        self.characterView.collectionView.delegate = self
        
        NetworkManager.shared.getCaracters() { [weak self] (characters) in
            guard let self = self else {return}
            self.characters = characters
            print (self.characters.count)
            self.characterView.collectionView.reloadData()
        }
    }
}

extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
         
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

extension CharacterViewController: UICollectionViewDelegate {
    
}

extension CharacterViewController: UICollectionViewDelegateFlowLayout {
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
