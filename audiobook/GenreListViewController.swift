//
//  ViewController.swift
//  audiobook
//
//  Created by Dang Huy on 5/23/17.
//  Copyright © 2017 ayanne. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class GenreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var genreTableView: UITableView!
        
    private var genreList = [Genre]()
    
    private var page = 1
    private var loadmore = true;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return genreList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("GenreTableViewCell", owner: self, options: nil)?.first as! GenreTableViewCell
        cell.title.text = genreList[indexPath.row].name
        cell.img.sd_setImage(with: URL(string: genreList[indexPath.row].genre_logo), placeholderImage: #imageLiteral(resourceName: "ic_launcher"), options: [.continueInBackground, .progressiveDownload])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AlbumListVC", sender: self.genreList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumListViewController {
            destination.selectedGenre = sender as! Genre
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.genreList.count - 1
        if self.loadmore && indexPath.row == lastElement {
            loadData()
        }
    }
    
    func loadData() {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        let requestUrl = UrlDefine.GENRE_URL + "?page=" + String(self.page)
        Alamofire.request(requestUrl)
            .responseJSON { (response) in
                SVProgressHUD.dismiss()
                if let value = response.result.value{
                    let json = JSON(value)
                    let data = json["data"].arrayValue
                    if data.count > 0 {
                        for item in data {
                            let genre = Genre(jsonObject: item)
                            self.genreList.append(genre)
                        }
                        self.genreTableView.reloadData()
                        self.page += 1
                    }else{
                        self.loadmore = false
                    }
                }
        }
        
    }
}

