//
//  Artist.swift
//  audiobook
//
//  Created by Dang Huy on 5/25/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import SwiftyJSON

class Artist {
    public var id = Int()
    public var create_date = String()
    public var update_date = String()
    public var name = String()
    
    init(jsonObject: JSON){
        self.id = jsonObject["id"].intValue
        self.name = jsonObject["name"].stringValue
        self.create_date = jsonObject["create_date"].stringValue
        self.update_date = jsonObject["update_date"].stringValue
    }
    
    init(){
        self.id = 0
        self.name = ""
        self.create_date = ""
        self.update_date = ""
    }
}
