//
//  StartViewController.swift
//  Marvelgram
//
//  Created by Нариман on 02.05.2021.
//

import UIKit
import IQKeyboardManager

class StartViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var instagramLayout: InstagramLayout!
    
    private let marvelgramUrl = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
    private var superHeroes: [SuperHero] = []
    private var selectedSuperHero: SuperHero?

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SuperHeroCollectionViewCell.self, forCellWithReuseIdentifier: "SuperHeroCell")

        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            searchField.backgroundColor = UIColor(red: 0.463, green: 0.463, blue: 0.502, alpha: 0.24)
            searchField.textColor = .white
        }
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear
        searchBar.isTranslucent = true
        searchBar.delegate = self

        populateData()
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailSegueId",
              let vc: DetailsViewController = segue.destination as? DetailsViewController,
              let superHero = selectedSuperHero else {
            return
        }
        vc.superHero = superHero
        vc.superHeroes = superHeroes
    }

    private func populateData() {
        if let url = URL(string: marvelgramUrl) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                do {
                    let res = try JSONDecoder().decode([SuperHero].self, from: data)
                    self.superHeroes = res
                    DispatchQueue.main.async { [unowned self] in
                        self.collectionView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
               }
           }.resume()
        }
    }

}

extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        for i in 0..<superHeroes.count {
            if superHeroes[i].name.lowercased().contains(searchText.lowercased()) || searchText == "" {
                superHeroes[i].active = true
            } else {
                superHeroes[i].active = false
            }
        }
        collectionView.reloadData()
    }
}

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let superHero = superHeroes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperHeroCollectionViewCell
        cell.setImage(url: superHero.thumbnail.fullPath(), active: superHero.active)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSuperHero = superHeroes[indexPath.row]
        performSegue(withIdentifier: "DetailSegueId", sender: nil)
    }

}
