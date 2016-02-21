//
//  LeaderBoardController.swift
//  Pokeman
//
//  Created by Jonathan Green on 2/20/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class LeaderBoardController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let myBoard = LeaderBoard()
    
    var scoreArray:[Score] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myBoard.getScores { (score) -> Void in
            
            self.scoreArray = score
            
            print(self.scoreArray.count)
            
            self.tableView.reloadData()
        }
        
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scoreArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ScoreCell = tableView.dequeueReusableCellWithIdentifier("ScoreCell") as! ScoreCell
        
        cell.score.text = "\(scoreArray[indexPath.row].score)"
        cell.name.text = scoreArray[indexPath.row].name
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
