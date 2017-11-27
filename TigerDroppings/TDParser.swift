//
//  TDParser.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/26/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import Fuzi
import HTMLReader

public class TDParser{
    
    var content: String!
    var type: String!
    init(htmlContent: String!, contentType: String!){
        
        content = htmlContent
        type = contentType
    }
    
    func getItems() -> NSMutableArray{
        let arr = NSMutableArray()
        if(type == "Threads"){
            do{
                let doc = try HTMLDocument(string: content,encoding: String.Encoding.utf8)
                //let mainDiv = doc.css(".ArtCont")
                for link in doc.css(".Art_Img") {
                    if(link["href"] != nil){
                        arr.add(link["href"] as Any)
                    }
                }
            }catch let error{
                print(error)
            }
            
        }
        return arr
    }
    
}
