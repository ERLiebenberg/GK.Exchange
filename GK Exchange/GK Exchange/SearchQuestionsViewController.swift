//
//  SearchQuestionsViewController.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/28.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

class SearchQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchBar: UISearchBar = {
       return searchController.searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        configureSearchController()
        configureSearchBar()
        configureTableView()
    }
    
    private func configureSearchController() {
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    private func configureSearchBar() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        searchBar.barTintColor = ColorKit.primaryColor
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .black
        searchBar.placeholder = NSLocalizedString("search.questions.searchbar.placeholder", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
    }
    
    private func configureTableView() {
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        questionsTableView.tableHeaderView = searchBar
        questionsTableView.tableFooterView = UIView()
    }
}

extension SearchQuestionsViewController: UITableViewDelegate {
    
}

extension SearchQuestionsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SearchQuestionsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
