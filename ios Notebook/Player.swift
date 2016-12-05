//
//  Player.swift
//  ios Notebook
//
//  Created by dawen wang on 16/10/24.
//  Copyright © 2016年 dawen wang. All rights reserved.
import Foundation

/*class Player: NSObject {
    var title: String
    var message: String
    var time:String
    var rating: Int
    
    init(title: String, message: String, time: String, rating: Int) {
        self.title = title
        self.message = message
        self.time=time
        self.rating = rating
        super.init()
    }
}*/



class UserInfo: NSObject,NSCoding{
    var title: String
    var message: String
    var time:String

init(title:String="",message:String="",time:String="")
{
    self.title = title
    self.message = message
    self.time=time
    super.init()
}

required init(coder aDecoder:NSCoder!)
{
    self.title=aDecoder.decodeObject(forKey: "Title") as! String
    self.message=aDecoder.decodeObject(forKey: "Message") as! String
    self.time=aDecoder.decodeObject(forKey: "Time") as! String
}
 func encode(with aCoder: NSCoder!)
{
    aCoder.encode(title, forKey: "Title")
    aCoder.encode(message, forKey: "Message")
    aCoder.encode(time, forKey: "Time")
 
}
}


