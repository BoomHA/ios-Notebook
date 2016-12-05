//
//  PlayersViewController.swift
//  ios Notebook
//
//  Created by dawen wang on 16/10/24.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class PlayersViewController: UITableViewController{

    //var players:[Player]=playersData
    var dataModel = DataModel()
    @IBAction func editBarBtnClick(_ sender: UIBarButtonItem) {
        //在正常状态和编辑状态之间切换
        if(self.tableView!.isEditing == false){
            self.tableView!.setEditing(true, animated:true)
            sender.title = "保存"
        }
        else{
            self.tableView!.setEditing(false, animated:true)
            sender.title = "编辑"
        }
        //重新加载表数据（改变单元格输入框编辑/只读状态）
        self.tableView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       //onCreateData()
        dataModel.loadData()
        tableView.reloadData()
    }

    
    /*func onCreateData(){
        dataModel.userList.append(UserInfo(title: "张三", message: "1234",time:"2016-5-02"))
        dataModel.userList.append(UserInfo(title: "李四", message: "1212",time:"2016-5-02"))
        dataModel.userList.append(UserInfo(title: "航歌", message: "3525",time:"2016-5-02"))
        dataModel.loadData()
    }*/
    
//    // UITableViewDelegate 方法，处理列表项的选中事件
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath)
//    {
//        self.tableView!.deselectRow(at: indexPath as IndexPath, animated: true)
//        let itemString = self.players[indexPath.row]
//        
//        self.performSegue(withIdentifier: "ShowDetailView", sender: itemString)
//    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.itemString=dataModel.userList[indexPath.row].title
                //controller.itemString = dataModel[indexPath.row].title
                controller.itemString2 = dataModel.userList[indexPath.row].message
                controller.itemString3 = dataModel.userList[indexPath.row].time
                controller.hangshu=indexPath.row
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.userList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath as IndexPath) as UITableViewCell //1
        let player = dataModel.userList[indexPath.row] as UserInfo //2
        if let titlelael = cell.viewWithTag(100) as? UILabel { //3
            titlelael.text = player.title
        }
        if let messagelabel = cell.viewWithTag(101) as? UILabel {
            messagelabel.text = player.message
        }
        if let timelabel = cell.viewWithTag(102) as? UILabel {
            //let date = NSDate()
            //let timeFormatter = DateFormatter()
            //timeFormatter.dateFormat = "yyy-MM-dd"
            //let strNowTime = timeFormatter.string(from: date as Date) as String
            //timelabel.text=strNowTime
            timelabel.text=player.time
        }
        return cell
    }
    


    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
        let playerDetailsViewController = segue.source as! PlayerDetailsViewController
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd HH:mm"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        //add the new player to the players array
        dataModel.userList.append(UserInfo(title: playerDetailsViewController.nameTextField.text!, message: playerDetailsViewController.messageTextField.text, time: strNowTime))
        
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        
        let indexPath=NSIndexPath(row: dataModel.userList.count-1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
    
        dataModel.saveData()
    }
    
    
    @IBAction func AlterDetailView(segue:UIStoryboardSegue) {
        let DetailViewController = segue.source as! DetailViewController
        let date1 = NSDate()
        let timeFormatter1 = DateFormatter()
        timeFormatter1.dateFormat = "yyy-MM-dd HH:mm"
        let strNowTime1 = timeFormatter1.string(from: date1 as Date) as String
        //add the new player to the players array
        dataModel.userList[DetailViewController.hangshu!] = UserInfo(title: DetailViewController.DetailsTitle.text!, message: DetailViewController.DetailsMessage.text, time: strNowTime1)
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
        dataModel.saveData()
        tableView.reloadData()
    }


    
    //在编辑状态，可以拖动设置cell位置
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //移动cell事件
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,to toIndexPath: IndexPath) {
        if fromIndexPath != toIndexPath{
            //获取移动行对应的值
            let itemValue:UserInfo = dataModel.userList[fromIndexPath.row]
            //删除移动的值
            dataModel.userList.remove(at: fromIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if toIndexPath.row > dataModel.userList.count{
                dataModel.userList.append(itemValue)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                dataModel.userList.insert(itemValue, at:toIndexPath.row)
            }
            dataModel.saveData()
        }
    }
    
    //删除
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCellEditingStyle
    {
        if(self.tableView.isEditing == false)
        {
            return UITableViewCellEditingStyle.none
        }
        else
        {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
        -> String? {
            return "确定删除？"
    }
    
    
    //编辑完毕（这里只有删除操作）
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath:IndexPath) {
        
        
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            self.dataModel.userList.remove(at: indexPath.row)
            self.tableView!.reloadData()
            print("你确认了删除按钮")
            dataModel.saveData()
        }
    }
    
    func imageForRating(rating:Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage(named: "1StarSmall")
        case 2:
            return UIImage(named: "2StarsSmall")
        case 3:
            return UIImage(named: "3StarsSmall")
        case 4:
            return UIImage(named: "4StarsSmall")
        case 5:
            return UIImage(named: "5StarsSmall")
        default:
            return nil
        }
    }
    
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
