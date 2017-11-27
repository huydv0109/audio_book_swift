//
//  Album.swift
//  audiobook
//
//  Created by Dang Huy on 5/25/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import SwiftyJSON

class Album {
     var id = Int()
     var album_title = String()
     var is_hot = String()
     var genre = [Genre]()
     var artist = Artist()
     var count_songs = Int()
     var create_date = String()
     var album_intro = String()
     var album_logo = String()
     var update_date = String()
     var view_count = Int()
    
    init(jsonObject: JSON){
        self.id = jsonObject["id"].intValue
        self.album_title = jsonObject["album_title"].stringValue
        self.is_hot = jsonObject["is_hot"].stringValue
        self.view_count = jsonObject["view_count"].intValue
        self.count_songs = jsonObject["count_songs"].intValue
        self.album_intro = jsonObject["album_intro"].stringValue
        self.album_logo = jsonObject["album_logo"].stringValue
        self.create_date = jsonObject["create_date"].stringValue
        self.update_date = jsonObject["update_date"].stringValue
        
        self.artist = Artist(jsonObject: jsonObject["artist"])
        
        var genreList = [Genre]()
        for item in jsonObject["genre"].arrayValue{
            let genre = Genre(jsonObject: item)
            genreList.append(genre)
        }
        self.genre = genreList
    }
    
}

