//
//  SampleData.swift
//  ios Notebook
//
//  Created by dawen wang on 16/10/24.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import Foundation

/*let playersData = [ Player(title:"A", message:"Thhh", time:"2014-02-12", rating: 4),
                    Player(title: "B", message: "tttt", time:"2014-02-12",rating: 5),
                    Player(title: "C", message: "qqqq", time:"2014-02-12",rating: 2) ]
 */


class DataModel: NSObject {
    var userList=[UserInfo]()
    override init(){
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
    }
    func saveData(){
        let data=NSMutableData()
        let archiver=NSKeyedArchiver(forWritingWith: data)
        archiver.encode(userList, forKey: "userList")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    func loadData(){
        let path=self.dataFilePath()
        let defaultManager=FileManager()
        if defaultManager.fileExists(atPath: path)
        {
            let data = NSData(contentsOfFile: path)
            let unarchiver=NSKeyedUnarchiver(forReadingWith: data! as Data)
            userList=unarchiver.decodeObject(forKey: "userList") as! Array
            unarchiver.finishDecoding()
        }
        
    }
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentationDirectory,FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
      return self.documentsDirectory().appending("userLIst.plist")
    }
    }
    
    
    
