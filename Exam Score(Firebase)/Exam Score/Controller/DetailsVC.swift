//
//  DetailsVC.swift
//  Exam Score
//
//  Created by Hasan Esat Tozlu on 22.09.2022.
//

import UIKit
import Firebase

class DetailsVC: UIViewController {

    @IBOutlet weak var lectureText: UITextField!
    @IBOutlet weak var score1Text: UITextField!
    @IBOutlet weak var score2Text: UITextField!
       
    var lecture: Scores?
    var reference: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let lecture = lecture {
            guard let lecture_name = lecture.ders_adi, let score1 = lecture.not1, let score2 = lecture.not2 else {return}
            lectureText.text = lecture_name
            score1Text.text = String(score1)
            score2Text.text = String(score2)
        }
        
        reference = Database.database().reference()
    }
    
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        
        guard let lecture = lecture else {return}
        
        if let lecture_id = lecture.not_id, let lectureName = lectureText.text, let score1 = Int(score1Text.text!), let score2 = Int(score2Text.text!) {
            
            updateData(lecture_id: lecture_id, lecture: lectureName, score1: score1, score2: score2)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        
        guard let lecture = lecture else {return}
        
        if let lecture_id = lecture.not_id {
            
            deleteData(lecture_id: lecture_id)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func updateData(lecture_id: String, lecture: String, score1: Int, score2: Int) {
        reference.child("notlar").child(lecture_id).updateChildValues(["ders_adi":lecture, "not1":score1, "not2":score2])
    }
    
    func deleteData(lecture_id: String) {
        reference.child("notlar").child(lecture_id).removeValue()
    }
    
}
