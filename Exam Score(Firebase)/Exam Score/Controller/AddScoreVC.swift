//
//  AddScoreVC.swift
//  Exam Score
//
//  Created by Hasan Esat Tozlu on 22.09.2022.
//

import UIKit
import Firebase

class AddScoreVC: UIViewController {

    @IBOutlet weak var lectureText: UITextField!
    @IBOutlet weak var score1Text: UITextField!
    @IBOutlet weak var score2Text: UITextField!
    
    var reference: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reference = Database.database().reference()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        if let lecture = lectureText.text, let score1 = score1Text.text, let score2 = score2Text.text {
            guard let score1Int = Int(score1), let score2Int = Int(score2) else {return}
            addScore(lecture: lecture, score1: score1Int, score2: score2Int)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func addScore(lecture: String, score1: Int, score2: Int) {
        let dictionary: [String:Any] = ["ders_adi":lecture, "not1": score1, "not2": score2]
        let newReference = reference.child("notlar").childByAutoId()
        newReference.setValue(dictionary)
    }
    
}
