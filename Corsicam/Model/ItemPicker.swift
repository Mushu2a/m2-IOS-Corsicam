//
//  ItemPicker.swift
//  Corsicam
//
//  Created by Jeremie Elbaz on 24/11/2017.
//  Copyright © 2017 Jeremie Elbaz. All rights reserved.
//

import UIKit

class ItemPicker: UIView {

    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var titre:UILabel!
    @IBOutlet weak var dateCourante:UILabel!
    @IBOutlet weak var url:UILabel!
    @IBOutlet weak var loading:UIActivityIndicatorView!
        
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 170))
      
        let bunlde = Bundle.main.loadNibNamed("ItemPickerView", owner: self, options: nil)![0] as! UIView
        
        self.addSubview(bunlde);
        self.loading.startAnimating()
        self.loading.isHidden = false
    }
    
    func updateImage(data: Data) {
        self.image.image = UIImage(data: data,scale:1.0)
        self.loading.stopAnimating()
        self.loading.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
}
