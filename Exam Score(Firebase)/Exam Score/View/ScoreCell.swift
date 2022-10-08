//
//  ScoreCell.swift
//  Exam Score
//
//  Created by Hasan Esat Tozlu on 22.09.2022.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var lectureLabel: UILabel!
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
