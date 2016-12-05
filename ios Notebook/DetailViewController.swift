//
//  DetailViewController.swift
//  ios Notebook
//
//  Created by dawen wang on 16/10/25.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var DetailsTitle: UITextField!
    @IBOutlet weak var DetailsMessage: UITextView!
    
     var itemString:String?
    var itemString2:String?
    var itemString3:String?
    var hangshu:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
          view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shouhui)))
        DetailsTitle?.text = itemString
        DetailsMessage?.text = itemString2
        timeLabel?.text = itemString3
        
        // Do any additional setup after loading the view.
    }
    required init(coder aDecoder: NSCoder) {
        print("init DetailViewController")
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("deinit DetailViewController")
    }

    
    
     func tableView1(_ ableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        if indexPath.section == 0 {
            DetailsTitle.becomeFirstResponder()
        }
    }
    

    //点击空白处收回键盘
    func shouhui(sender: UITapGestureRecognizer){
        if sender.state == . ended
        {
            DetailsTitle.clearButtonMode = .whileEditing
            DetailsTitle.resignFirstResponder()
        }
        if sender.state == . ended
        {
            DetailsMessage.resignFirstResponder()
        }
        sender.cancelsTouchesInView=false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
