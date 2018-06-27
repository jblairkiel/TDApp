//
//  APIManager.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/26/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import Alamofire
import UIKit

public class APIManager {
    
    
    init(){
        
    }
    
    public func makeHTTPGetRequest(path: String, success: @escaping (String) -> Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(path).responseJSON {
            response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            //if let json = response.result.value {
                //debugPrint("JSON: \(json)") // serialized json response
            //}
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //debugPrint("Data: \(utf8Text)") // original server data as UTF8 string
                success(utf8Text)
            }
        }
    }

}
