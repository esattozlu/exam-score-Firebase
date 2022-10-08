//
//  ViewController.swift
//  Exam Score
//
//  Created by Hasan Esat Tozlu on 22.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var scoresTableView: UITableView!
    
    var scoreList = [Scores]()
    var reference: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        
        reference = Database.database().reference()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.getData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? Int else {return}
        if let destinationVC = segue.destination as? DetailsVC {
            destinationVC.lecture = scoreList[index]
        }
    }
    
    func getData() {
        reference.child("notlar").observe(.value) { snapshot in
            if let dataFire = snapshot.value as? [String:AnyObject] {
                self.scoreList.removeAll()
                
                for data in dataFire {
                    if let dictionary = data.value as? NSDictionary {
                        let key = data.key
                        let lecture = dictionary["ders_adi"] as? String ?? ""
                        let score1 = dictionary["not1"] as? Int ?? -1
                        let score2 = dictionary["not2"] as? Int ?? -1
                        
                        let lect = Scores(not_id: key, ders_adi: lecture, not1: score1, not2: score2)
                        self.scoreList.append(lect)
                    }
                }

            } else {
                self.scoreList.removeAll()
            }
            
            DispatchQueue.main.async {
                
                var sum = 0
                for score in self.scoreList {
                    guard let score1 = score.not1, let score2 = score.not2 else {return}
                    sum += (score1+score2)/2
                }
                
                if self.scoreList.count != 0 {
                    self.navigationItem.prompt = "Avg: \(sum/self.scoreList.count)"
                } else {
                    self.navigationItem.prompt = "Avg: 0"
                }
                self.scoresTableView.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Lecture = scoreList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreCell
        cell.lectureLabel.text = Lecture.ders_adi
        cell.score1Label.text = String(Lecture.not1!)
        cell.score2Label.text = String(Lecture.not2!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toScoreDetails", sender: indexPath.row)
    }
    
}
