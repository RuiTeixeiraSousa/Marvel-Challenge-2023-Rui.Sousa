//
//  HomeViewController.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let marvelAPI = MarvelAPI.shared
    private var characters: [Character] = []
    private var filteredCharacters: [Character] = []
    private var isSearching: Bool = false
    private var currentPage = 0
    private var totalPages = 100
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacters(page: 0)
    }
    
    private func setupUI() {
        searchBar.delegate = self
        tableView.register(UINib(nibName: "MarvelTableViewCell", bundle: nil), forCellReuseIdentifier: "MarvelTableViewCell")
    }
    
    private func fetchCharacters(page: Int) {
        marvelAPI.characterService.character(nil, page: page, limit: 100) { [weak self] result in
            switch result {
            case .success(let characterDataWrapper):
                guard let self = self else { return }
                self.currentPage = (characterDataWrapper.data?.offset ?? 0)/(characterDataWrapper.data?.limit ?? 1) + 1
                self.totalPages = (characterDataWrapper.data?.total ?? 0)/(characterDataWrapper.data?.limit ?? 1)
                self.characters += characterDataWrapper.data?.results ?? []
                self.filteredCharacters += characterDataWrapper.data?.results ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("Character data wrapper: \(characterDataWrapper.description)")
            case .failure(let error):
                print("Error fetching characters: \(error.userInfo["message"] ?? "unknown")")
            }
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentYoffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if currentPage < totalPages && contentYoffset >= maximumOffset {
            fetchCharacters(page: currentPage + 1)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelTableViewCell", for: indexPath) as! MarvelTableViewCell
        let character = filteredCharacters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = filteredCharacters[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: selectedCharacter)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let detailVC = segue.destination as? DetailsViewController {
                detailVC.characterDetails = sender as? Character
                }
            }
        }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = searchText.isEmpty ? characters : characters.filter { (item: Character) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}
