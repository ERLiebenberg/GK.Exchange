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
    
    private let cellIdentifier = "cell"
    private let questionSegue = "questionSegue"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchBar: UISearchBar = {
       return searchController.searchBar
    }()
    
    fileprivate lazy var viewModel: SearchQuestionsViewModel = {
       return SearchQuestionsViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureView() {
        configureSearchController()
        configureSearchBar()
        configureTableView()
    }
    
    private func configureSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func configureSearchBar() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        searchBar.delegate = self
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
        configureTableViewBackgroundView()
    }
    
    private func configureTableViewBackgroundView() {
        let backgroundLabel = configureBackgroundLabel()
        
        let backgroundContainerView = UIView(frame: .zero)
        backgroundContainerView.addSubview(backgroundLabel)
        
        backgroundLabel.centerXAnchor.constraint(equalTo: backgroundContainerView.centerXAnchor).isActive = true
        backgroundLabel.centerYAnchor.constraint(equalTo: backgroundContainerView.centerYAnchor).isActive = true
        
        questionsTableView.backgroundView = backgroundContainerView
    }
    
    private func configureBackgroundLabel() -> UILabel {
        let backgroundLabel = UILabel()
        backgroundLabel.text = NSLocalizedString("search.questions.bacground.title", tableName: "GlobalStrings", bundle: Bundle.main, comment: "")
        backgroundLabel.textColor = .darkGray
        backgroundLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundLabel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == questionSegue, let dvC = segue.destination as? QuestionViewController, let questionModel = sender as? QuestionModel {
            dvC.questionModel = questionModel
        }
    }
}

extension SearchQuestionsViewController: SearchQuestionsView {
    
    func reloadTableView() {
        questionsTableView.reloadData()
    }
    
    func presentErrorMessage(_ errorMessage: String?) {
        ///TODO: implement error alert view
    }
}

extension SearchQuestionsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchQuestions(query: searchBar.text)
    }
}

extension SearchQuestionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: questionSegue, sender: viewModel.question(at: indexPath.row))
    }
}

extension SearchQuestionsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionCell {
            cell.titleLabel.text = viewModel.title(at: indexPath.row)
            cell.ownerNameLabel.text = viewModel.ownerName(at: indexPath.row)
            cell.numberOfVotesLabel.text = viewModel.numberOfVotes(at: indexPath.row)
            cell.numberOfAnswersLabel.text = viewModel.numberOfAnswers(at: indexPath.row)
            cell.numberOfViewsLabel.text = viewModel.numberOfViews(at: indexPath.row)
            cell.configureCell(isAnswered: viewModel.isQuestionAnswered(at: indexPath.row))
            
            return cell
        }
        
        return UITableViewCell()
    }
}
