//
//  DetailsViewController.swift
//  Marvelgram
//
//  Created by Нариман on 02.05.2021.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var exploreMoreCollection: UICollectionView!

    var superHero: SuperHero = SuperHero()
    var superHeroes: [SuperHero] = []
    private var randomSuperHeroes: [SuperHero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.sd_setImage(
            with: URL(string: superHero.thumbnail.fullPath()),
            placeholderImage: nil
        )
        descriptionText.text = superHero.description
        title = superHero.name
        exploreMoreCollection.register(SuperHeroCollectionViewCell.self, forCellWithReuseIdentifier: "SuperHeroCell")
        exploreMoreCollection.delegate = self
        exploreMoreCollection.dataSource = self
        exploreMoreCollection.reloadData()

        var filteredSuperHeroes = superHeroes.filter { $0.id != superHero.id }
        filteredSuperHeroes.shuffle()
        var count = 10
        if filteredSuperHeroes.count < 10 {
            count = filteredSuperHeroes.count
        }
        randomSuperHeroes = Array(filteredSuperHeroes.prefix(upTo: count))
    }

}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomSuperHeroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let superHero = randomSuperHeroes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperHeroCollectionViewCell
        cell.setImage(url: superHero.thumbnail.fullPath(), active: true)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSuperHero = randomSuperHeroes[indexPath.row]
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        vc.superHero = selectedSuperHero
        vc.superHeroes = superHeroes
        navigationController?.pushViewController(vc, animated: true)
    }

}
