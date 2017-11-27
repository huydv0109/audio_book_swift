//
//  GenreViewController.swift
//  audiobook
//
//  Created by Dang Huy on 5/24/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class AlbumListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var albumTableView: UITableView!
    
    var selectedGenre : Genre!
    
    private var albumList = [Album]()
    
    private var page = 1
    private var loadmore = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedGenre.name
        
        self.albumTableView.dataSource = self
        self.albumTableView.delegate = self
        
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AlbumTableViewCell", owner: self, options: nil)?.first as! AlbumTableViewCell
        cell.title.text = albumList[indexPath.row].album_title
        cell.img.sd_setImage(with: URL(string: albumList[indexPath.row].album_logo), placeholderImage: #imageLiteral(resourceName: "ic_launcher"), options: [.continueInBackground, .progressiveDownload])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.albumList.count - 1
        if self.loadmore && indexPath.row == lastElement {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AlbumDetailVC", sender: self.albumList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumDetailViewController {
            destination.selectedAlbum = sender as! Album
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83;
    }
    
    func loadData(){
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        let requestUrl = UrlDefine.ALBUM_BY_GENRE_URL + "/" + String(self.selectedGenre.id) + "?page=" + String(self.page)
        Alamofire.request(requestUrl)
            .responseJSON { (response) in
                SVProgressHUD.dismiss()
                if let value = response.result.value{
                    let json = JSON(value)
                    let data = json["data"].arrayValue
                    if data.count > 0 {
                        for item in data{
                            let album = Album(jsonObject: item)
                            self.albumList.append(album)
                        }
                        self.albumTableView.reloadData()
                        self.page += 1
                    }else {
                        self.loadmore = false
                    }
                }
        }
        
    }
    
}
