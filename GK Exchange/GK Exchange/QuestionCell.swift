//
//  QuestionCell.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/08/29.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    private let checkImageName = "check"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var numberOfVotesLabel: UILabel!
    @IBOutlet weak var numberOfAnswersLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var isAnsweredImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleLabels()
    }
    
    func configureCell(isAnswered: Bool) {
        isAnsweredImageView.image = UIImage(named: checkImageName)
        isAnsweredImageView.isHidden = !isAnswered
    }
    
    private func styleLabels() {
        titleLabel.textColor = ColorKit.primaryColor
        ownerNameLabel.textColor = .lightGray
        numberOfVotesLabel.textColor = .lightGray
        numberOfAnswersLabel.textColor = .lightGray
        numberOfViewsLabel.textColor = .lightGray
    }
}


