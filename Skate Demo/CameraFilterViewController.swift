//
//  CameraFilterViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 12/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit

class CameraFilterViewController: UIViewController {
    
    @IBOutlet weak var filterImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
    }
    
    
}

extension CameraFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        return cell
            
            
            
        }
        
    }
    
