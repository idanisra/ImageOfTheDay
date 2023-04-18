//
//  RSSParser.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import Foundation

class RSSParser: NSObject {
    
    private var rssItems: [RSSItem] = []
    private var currentElement: String = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle.parseNewLines()
        }
    }
    
    private var currentDescription: String = "" {
        didSet {
            currentDescription.parseNewLines()
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate.parseNewLines()
        }
    }
    
    private var currentLink: String = "" {
        didSet {
            currentLink.parseNewLines()
        }
    }
    
    private var currentEnclosure: String = "" {
        didSet {
            currentEnclosure.parseNewLines()
        }
    }
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseRssXml(from data: Data, with completionHandler: (([RSSItem]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}

extension RSSParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
 
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentLink = ""
        }
        
        if currentElement == "enclosure" {
            currentEnclosure = attributeDict["url"] ?? ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "pubDate": currentPubDate += string
        case "link": currentLink += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, link: currentLink, description: currentDescription, pubDate: currentPubDate, enclosure: currentEnclosure)
            rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
        print(parseError.localizedDescription)
    }
}
