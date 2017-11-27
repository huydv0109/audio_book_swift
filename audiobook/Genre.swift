//
//  Genre.swift
//  audiobook
//
//  Created by Dang Huy on 5/24/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import SwiftyJSON

class Genre {
    var id  = Int()
    var name = String()
    var genre_logo = String()
    var view_count = Int()
    var create_date = String()
    var update_date = String()
    
    init(jsonObject: JSON){
        self.id = jsonObject["id"].intValue
        self.name = jsonObject["name"].stringValue
        self.genre_logo = jsonObject["genre_logo"].stringValue
        self.view_count = jsonObject["view_count"].intValue
        self.create_date = jsonObject["create_date"].stringValue
        self.update_date = jsonObject["update_date"].stringValue
    }
}
