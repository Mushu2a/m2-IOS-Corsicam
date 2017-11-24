//
//  Store.swift
//  Corsicam
//
//  Created by Jeremie Elbaz on 24/11/2017.
//  Copyright © 2017 Jeremie Elbaz. All rights reserved.
//

import Foundation

class Store: NSObject, URLSessionDataDelegate {

    private var dataURL: String
    private var dataBuffer: Data!
    private var parentCTRL: ViewController
    private var row: Int
    
    init(withRSSDataURL rssDataURL: String,
         parentCTRL: ViewController, row: Int) {
        self.dataURL = rssDataURL
        self.parentCTRL = parentCTRL
        self.row = row
    }
    
    func getData() {
        var httPostRequest: URLRequest!
        self.dataBuffer = nil
        
        let sessionConfig = URLSessionConfiguration.default
        
        let rssURL = URL(string:self.dataURL)
        
        httPostRequest = URLRequest(url:rssURL!)
        httPostRequest?.httpMethod = "GET"
        
        let mainSession = URLSession(configuration: sessionConfig,
                                     delegate: self, delegateQueue: OperationQueue.current)
        
        let mainTask = mainSession.dataTask(with: httPostRequest!)
        
        mainTask.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if (self.dataBuffer != nil ) {
            self.dataBuffer = self.dataBuffer + data
        } else {
            self.dataBuffer = data
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if(error != nil) {
            self.parentCTRL.networkErrorOccurred(pErrorMessage: error!.localizedDescription)
        } else {
            self.parentCTRL.receiveRSSData(imageData: self.dataBuffer, row: self.row)
        }
    }
}
