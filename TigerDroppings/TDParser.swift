//
//  TDParser.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/26/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import SwiftSoup

public class TDParser{
    
    enum ParseError: Error {
        case FoundNil(String)
    }
    
    var content: String!
    var type: String!
    init(htmlContent: String!, contentType: String!){
        
        content = htmlContent
        type = contentType
    }
    
    func getItems(tdForum: String?) -> [Thread]{
        var arr = [Thread]()
        if(type == "Home"){
            do{
                //switched author with description need to change later
                let doc: Document = try! SwiftSoup.parse(content)
                let artSec: Elements = try! doc.getElementsByClass("Art_Sec")
                for article: Element in artSec.array(){
                    if(article.tagName() != "h1"){
                        let link: String = try! article.getElementsByClass("Art_Title1").attr("href")
                        let title: String = try! article.getElementsByClass("Art_Title1").text()
                        let author: String = try! article.getElementsByClass("Art_Text2").text()
                        let desc: String = ""
                        var img: String = try! article.getElementsByClass("Art_Img1").select("a").first()!.attr("style")
                        img = img.replacingOccurrences(of: "background-image: url('", with: "")
                        img = img.replacingOccurrences(of: "');", with: "")
                        arr.append(Thread(title: title, author: author, link: link, desc: desc, backImage: img, forum: tdForum, replyCount: "", lastComment: "")!)
                    //}
                    }
                }
            }
            
        }
            //Default threads
        else{
            let doc: Document = try! SwiftSoup.parse(content)
            let threadTable: Element? = try! doc.getElementsByClass("Index").first()
            let threads: [Element] = try! threadTable!.getElementsByTag("tr").array()
            for thread: Element in threads{
                if(try! thread.attr("class") != "TopicHead"){
                    let tds: [Element] = try! thread.getElementsByTag("td").array()
                    let link: String = try! tds[0].getElementsByTag("a").attr("href")
                    let title: String = try! tds[0].getElementsByTag("a").text()
                    let desc: String = ""
                    let img: String = ""
                    let author: String = try! tds[1].getElementsByTag("a").text()
                    let replyCount: String = try! tds[2].text()
                    let lastComment: String = try! tds[3].text()
                    arr.append(Thread(title: title, author: author, link: link, desc: desc, backImage: img, forum: tdForum, replyCount: replyCount, lastComment: lastComment)!)
                }
            }
        }
        return arr
    }
}
    
