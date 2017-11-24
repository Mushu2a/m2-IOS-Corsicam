//
//  ViewController.swift
//  Corsicam
//
//  Created by Jeremie Elbaz on 24/11/2017.
//  Copyright © 2017 Jeremie Elbaz. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: variables
    private var storeObject: Store!
    private var tabItem: [Int:DataStore] = Dictionary<Int, DataStore>()
    var pickerData: [String] = [String]()
    var CAMS:[(String,String)] = []
    //MARK: Outlet
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var patientez: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var btnSave: UIButton!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettingsBundle()
        updateDisplayFromDefaults()
        
        self.storeObject = Store(withRSSDataURL: CAMS[0].1, parentCTRL: self, row: 0)
        storeObject.getData()
        // Delegation
        self.picker.delegate = self
        self.picker.dataSource = self
        self.titre.text = CAMS[0].0

        for url in CAMS {
            pickerData.append(url.0)
        }
        self.waitMessage(status: true)
        
        self.btnSave.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
    }
    
    @objc func saveImage() {
        UIImageWriteToSavedPhotosAlbum(self.image.image!, self, nil, nil)
        let alert = UIAlertController(title: "GREAT !", message: "Photo sauvegardée", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveRSSData(imageData: Data, row: Int) {
        self.waitMessage(status: false)
        self.image.image = UIImage(data: imageData,scale:1.0)
        
        let item = self.picker.view(forRow: row, forComponent: 0) as! ItemPicker
        if (self.tabItem[row] == nil) {
            self.tabItem[row] = DataStore(titre: CAMS[row].1, data: imageData)
        }
        item.dateCourante.text = self.tabItem[row]!.date
        item.updateImage(data: self.tabItem[row]!.data)
    }
    
    func networkErrorOccurred(pErrorMessage: String) {
        let alertFrmCtrl = UIAlertController(title: "Network error", message: pErrorMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertFrmCtrl.addAction(OKAction)
        self.present(alertFrmCtrl, animated: true, completion: nil)
    }
    
    //MARK: wait
    func waitMessage(status: Bool) {
        if (status) {
            self.indicator.startAnimating()
            self.indicator.isHidden = false
            self.patientez.isHidden = false
        } else {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.patientez.isHidden = true
        }
    }
    
    
    //MARK: Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let itemPicker = ItemPicker()
        itemPicker.titre.text = CAMS[row].0
        itemPicker.url.text = CAMS[row].1
        if (self.tabItem[row] != nil) {
            itemPicker.updateImage(data: self.tabItem[row]!.data)
            itemPicker.dateCourante.text = self.tabItem[row]!.date
        }
        return itemPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 170
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (self.tabItem[row] != nil) {
            self.image.image = UIImage(data: self.tabItem[row]!.data)
        } else {
            self.waitMessage(status: true)
            self.storeObject = Store(withRSSDataURL: CAMS[row].1, parentCTRL: self, row: row)
            storeObject.getData()
        }
        self.titre.text = CAMS[row].0
    }
    
    //MARK: preferences
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    func updateDisplayFromDefaults(){
        //Get the defaults
        let defaults = UserDefaults.standard
        let corse = defaults.bool(forKey: "preference_corse")
        let paris = defaults.bool(forKey: "preference_paris")

        let itemURL = ItemURL()
        if (corse) {
            self.CAMS = itemURL.corse(datas: self.CAMS)
        }
        if (paris) {
            self.CAMS = itemURL.paris(datas: self.CAMS)
        }
    }

    
    


}

