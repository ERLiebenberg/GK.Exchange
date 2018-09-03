//
//  QuestionViewController.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionBodyLabel: UILabel!
    
    @IBOutlet weak var questionTagsLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerReputationLabel: UILabel!
    @IBOutlet weak var questionDateLabel: UILabel!
    
    var questionModel: QuestionModel?
    
    private lazy var viewModel: QuestionViewModel = {
        return QuestionViewModel(view: self, questionModel: questionModel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = ColorKit.primaryColor
        navigationController?.navigationBar.isTranslucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        
        viewModel.configureView()
    }
}

extension QuestionViewController: QuestionView {

    func setQuestionTitle(_ title: String?) {
        questionTitleLabel.text = title
    }
    
    func setQuestionBody(htmlString: String) {
        let data = Data(htmlString.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            questionBodyLabel.attributedText = attributedString
            questionBodyLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    func setTags(_ tags: String) {
        questionTagsLabel.text = tags
    }
    
    func setOwnerProfileImage(imageData: Data) {
        ownerImageView.image = UIImage(data: imageData)
    }
    
    func setOwnerName(_ ownerName: String?) {
        ownerNameLabel.text = ownerName
    }
    
    func setOwnerReputation(_ ownerReputation: String) {
        ownerReputationLabel.text = ownerReputation
    }
    
    func setQuestionDate(_ date: String) {
        questionDateLabel.text = date
    }
}
