//
//  SearchViewController.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - UI
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search meanings"
        return searchController
    }()
    
    //MARK: - Constraints
    let viewModel = WordSearchViewModel()
    var timer = Timer()
    
    var searchResult: SearchResult? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var foundMeanings: [Meaning] {
        get {
            if let nonEmptyMeanings = searchResult?.meanings {
                return nonEmptyMeanings
            } else {
                return []
            }
        }
    }
    
    var searchState: SearchState = .empty {
        didSet {
            handleSearchStateChange()
        }
    }
    
    var showPlaceholderText = false {
        didSet {
            tableView.reloadData()
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        setDelegates()
        configureMainView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    //MARK: - Actions
    func configureNavBar() {
        title = "WordSearch"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func configureMainView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        let mainConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(mainConstraints)
        
        let footerView = UIView()
        tableView.tableFooterView = footerView
        
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier)
    }
    
    func handleSearchStateChange() {
        switch searchState {
        case .empty:
            showPlaceholderText = false
        case .noResult:
            showPlaceholderText = true
        case .searching:
            showPlaceholderText = true
        case .showingResults:
            showPlaceholderText = false
        }
    }
}

//MARK: - UISearchBar
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            timer.invalidate()
            
            if searchText.count > 1 {
                if foundMeanings.isEmpty {
                    searchState = .searching
                }
                
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchForWords(sender:)), userInfo: searchText, repeats: false)
            }  else {
                searchResult = nil
                searchState = .empty
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchForWords(sender: Timer) {
        guard let searchText = sender.userInfo as? String else { return }

        viewModel.searchWord(searchText) { [weak self] (searchResult, error) in
            DispatchQueue.main.async {
                if let nonEmpyError = error {
                    self?.searchState = .noResult
                    print(nonEmpyError.localizedDescription)
                } else if let nonEmptyResult = searchResult {
                    self?.searchState = .showingResults
                    self?.searchResult = nonEmptyResult
                } else {
                    self?.searchState = .noResult
                }
            }
        }
    }
}

//MARK: - UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showPlaceholderText {
            return 1
        } else {
            return foundMeanings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.searchResultTableViewCellIdentifier, for: indexPath) as? SearchResultTableViewCell, let meaning = foundMeanings[safe: indexPath.row] {
            
            cell.meaningPreviewImageView.loadImageFromURL(url: meaning.fixedPreviewURL ?? "")
            cell.meaningLabel.text = meaning.translation?.text
            
            return cell
        } else {
            let cell = UITableViewCell()
            
            if showPlaceholderText {
                cell.textLabel?.text = searchState.rawValue
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let meaningToShow = foundMeanings[safe: indexPath.row], let searchText = searchResult?.text {
            let detailedMeaningVC = DetailedMeaningViewController(searchWord: searchText, meaning: meaningToShow)
            let navController = UINavigationController(rootViewController: detailedMeaningVC)

            navigationController?.present(navController, animated: true, completion: nil)
        }
    }
}

