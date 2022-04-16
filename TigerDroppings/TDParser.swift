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
    func getComments(tdForum: String?) -> [Comment]{
        var arr = [Comment]()
        do{
            var elArray = Array<Element?>()
            let doc: Document = try! SwiftSoup.parse(content)
            let body: Element = (try! doc.getElementsByClass("Index").first())!
            //let comments: Elements = try! body.getElementsByClass("row")
            let comments: Elements = body.children()
            
            var commentIter: Int = 0
            var firstEl: Element? = nil
            var i: Int = 1
            var comment: Element? = nil
            //for comment: Element in comments.array(){
            while(i < comments.array().count){
                
                comment = comments.array()[i]
                var author: String = ""
                let authorEL: Elements = try! comment!.getElementsByClass("RegUser")
                if(authorEL.isEmpty()){
                    author = ""
                }else{
                    author = try! (authorEL.first()?.text())!
                }
                if(author == "SR Sponsor"){
                    i = i+2
                    continue
                }
                else{
                    commentIter += 1
                    //if(commentIter == 3){
                    //    commentIter = 0
                    //}else
                    if (commentIter == 2){
                        try! firstEl?.append((comment?.html())!)
                        elArray.append(firstEl)
                        commentIter = 0
                    }else{
                        firstEl = comment
                    }
                    i += 1
                }
            }
            for comment: Element? in elArray{
                if(comment?.tagName() != "h1"){
                    let contentEl: Elements = try! comment!.getElementsByClass("pText")
                    var content = Array<Element?>()
                    if(!contentEl.isEmpty()){
                        content = contentEl.array()
                    }
                    let link: String = " "
                    let author: String = try! comment!.getElementsByClass("RegUser").first()!.text()
                    let authorLink: String = try! comment!.getElementsByClass("RegUser").first()!.attr("href")
                    let avatarEl: Elements = try! comment!.getElementsByClass("ava")
                    var avatar: String = " "
                    if(!avatarEl.isEmpty()){
                        avatar = try! avatarEl.attr("src")
                    }
                    let signatureEl: Elements = try! comment!.getElementsByClass("SigText")
                    var signature: String = " "
                    if(!signatureEl.isEmpty()){
                        signature = try! signatureEl.first()!.text()
                    }
                    
                    let signaturePicEl: Elements = try! comment!.getElementsByClass("Sig")
                    var signaturePic: String = " "
                    if(!signaturePicEl.isEmpty()){
                        signaturePic = try! signaturePicEl.first()!.attr("src")
                    }
                    var commentDetails: String = try! comment!.getElementsByClass("PostInfo").first()!.text()
                    if(commentDetails == " "){
                        commentDetails = (try! comment?.getElementsByClass("editText").first()!.text())!
                    }
                    let likesUpE: Elements = try! comment!.getElementsByClass("mbThUp")
                    var likesUp: String = ""
                    if(!likesUpE.isEmpty()){
                        likesUp = try! likesUpE.first()!.text()
                    }else{
                        likesUp = "0"
                    }
                    let likesDownEl: Elements = try! comment!.getElementsByClass("mbThDown")
                    var likesDown: String = ""
                    if(!likesDownEl.isEmpty()){
                        likesDown = try! likesDownEl.first()!.text()
                    }else{
                        likesDown = "0"
                    }
                    if(author == "SR Sponsor" || author == "TD Sponsor"){
                        do{
                            let html: String = "<p></p>";
                            let doc: Document = try SwiftSoup.parse(html)
                            let dummy: Array<Element> = try doc.select("p").array()
                            arr.append(Comment(content: dummy, author: "SR Sponsor", link: "#", authorLink: "#", avatar: "", signature: "", signaturePic: "", commentDetails: "", likesUp: "", likesDown: "")!)
                        }catch Exception.Error(let _, let message) {
                            print(message)
                        } catch {
                            print("error")
                        }
                        
                    }else{
                        arr.append(Comment(content: content, author: author, link: link, authorLink: authorLink, avatar: avatar, signature: signature, signaturePic: signaturePic, commentDetails: commentDetails, likesUp: likesUp,likesDown: likesDown)!)
                    }
                }
            }
            return arr
        }
    }
    
    func getThreads(tdForum: String?) -> [Thread]{
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
    
