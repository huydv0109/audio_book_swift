//
//  AlbumDetailViewController.swift
//  audiobook
//
//  Created by Dang Huy on 6/27/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    @IBOutlet weak var presentImage: UIImageView!

    @IBOutlet weak var audioName: UILabel!
    @IBOutlet weak var partCount: UILabel!
    @IBOutlet weak var genreName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    var selectedAlbum : Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentImage.sd_setImage(with: URL(string:selectedAlbum.album_logo), placeholderImage: #imageLiteral(resourceName: "ic_launcher"), options: [.continueInBackground, .progressiveDownload])
        audioName.text = selectedAlbum.album_title
        partCount.text = String(selectedAlbum.count_songs)
        
        var genreText = ""
        for genre in selectedAlbum.genre{
            genreText = genre.name + ", "
        }
        let endIndex = genreText.index(genreText.endIndex, offsetBy: -2)
        genreName.text = genreText.substring(to: endIndex)
        
        artistName.text = selectedAlbum.artist.name
        viewCount.text = String(selectedAlbum.view_count)
        createDate.text = selectedAlbum.create_date
        updateDate.text = selectedAlbum.update_date
    }

}
