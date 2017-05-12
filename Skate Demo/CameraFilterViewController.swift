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
    
    var selectedFilterImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        filterImage.image = selectedFilterImage
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
    }
    
    //Resize collection view image so load is quicker
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
            
            
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
}

extension CameraFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        let newImage = resizeImage(image: selectedFilterImage, newWidth: 150)
        
        print(newImage.size)
        
        // Create a filter object from filter class - core image filter class
        
        let ciImage = CIImage(image: newImage)
        
        let filter = CIFilter(name: "CISepiaTone")
        
        //Specify corrosponding key so filter knows what putting in
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filteredImage = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            
            cell.filterForPhoto.image = UIImage(ciImage: filteredImage)

            
        }
        
        
        return cell
            
            
            
        }
        
    }
    
