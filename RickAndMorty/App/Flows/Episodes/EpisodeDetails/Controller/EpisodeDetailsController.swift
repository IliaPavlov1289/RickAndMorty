//
//  EpisodeDetailsController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 27.11.2021.
//

import UIKit

class EpisodeDetailsController: UIViewController {

    private enum Constants {
        static let spacing: CGFloat = 16.0
        static let heightCardDescription: CGFloat = 79.0
        static let itemsInRow: CGFloat = 2.0
    }
    
    private var episodeDetailsView: DetailsView {
        return self.view as! DetailsView
    }
    private var episode: Episode
    private var characters = [Character]()
    private var charactersImage = [UIImage]()

    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = DetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createLocationDetailsHeaderView()
        self.episodeDetailsView.collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
        self.episodeDetailsView.collectionView.delegate = self
        self.episodeDetailsView.collectionView.dataSource = self
        self.episodeDetailsView.residentslabel.text = "Characters"
        
        self.createNavigationTitle()
        self.setupBackButton()
        self.getCharacters()
    }
    private func createLocationDetailsHeaderView() {
        
        self.episodeDetailsView.locationDetailsHeaderView.upLabel.text = episode.airDate
        self.episodeDetailsView.locationDetailsHeaderView.nameLabel.text = episode.name
        self.episodeDetailsView.locationDetailsHeaderView.downLabel.text = episode.episode.uppercased()
    }
    
    private func createNavigationTitle(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = episode.name
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.init(name: "SFProText-Semibold", size: 15.0) ?? UIFont.systemFont(ofSize: 15.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBackButton() {
        let backButton = UIButton.createBackButton()
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func getCharacters() {
        self.episode.characters.forEach({ NetworkManager.shared.getCharacter(url: $0) { [weak self] (character) in
            guard let self = self else {return}
                NetworkManager.shared.getImage(fromUrl: character.image) { (image) in
                    guard let image = image else { return }
                    DispatchQueue.main.async {
                        self.characters.append(character)
                        self.charactersImage.append(image)
                        self.episodeDetailsView.collectionView.reloadData()
                    }
                }
        }})
    }
}

extension EpisodeDetailsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as! CharactersCollectionViewCell
         
        cell.nameLabel.text = self.characters[indexPath.row].name
        cell.statusLabel.text = self.characters[indexPath.row].status
        cell.characterImageView.image = charactersImage[indexPath.row]

        return cell
    }
}

extension EpisodeDetailsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterDetailsController = CharacterDetailsController(character: self.characters[indexPath.row])
        navigationController?.pushViewController(characterDetailsController, animated: true)
    }
}

extension EpisodeDetailsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: self.view.frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: width + Constants.heightCardDescription)
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
