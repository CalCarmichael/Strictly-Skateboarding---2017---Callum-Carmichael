//
//  ExploreViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 22/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import ProgressHUD

class ExploreViewController: UIViewController {
    
    var posts: [Post] = []
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var exploreCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(ExploreViewController.loadPopularPosts), for: .valueChanged)
        
        exploreCollectionView.refreshControl = refreshControl
        exploreCollectionView.addSubview(refreshControl)
        
        loadPopularPosts()
        
        let flow = exploreCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flow.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0)
        
        navigationController?.hidesBarsOnTap = false
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.hidesBarsOnTap = false
        
    }
    
    
    func loadPopularPosts() {
        
       // ProgressHUD.show("Loading Posts...", interaction: false)
        
        self.posts.removeAll()
        
        self.exploreCollectionView.reloadData()
        
        Api.Post.observePopularPosts { (post) in
            
            self.posts.append(post)
            self.exploreCollectionView.reloadData()
            
            self.refreshControl.endRefreshing()
            
          //  ProgressHUD.dismiss()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Explore_DetailSegue" {
            let exploreDetailVC = segue.destination as! ExploreDetailViewController
            let postId = sender as! String
            exploreDetailVC.postId = postId
        }
        
    }

}

//Same as profile just change for Explore

extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        //Display posts at certain array index on corresponding row
        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self 
        return cell
    }
    
    
}

//Creating the UI for the cells on explore page

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 2 , height: collectionView.frame.size.width / 3 - 2)
    }
    
}

extension ExploreViewController: PhotoCollectionViewCellDelegate {
   
    func goToDetailVC(postId: String) {
        
        performSegue(withIdentifier: "Explore_DetailSegue", sender: postId)
        
    }
   
}
