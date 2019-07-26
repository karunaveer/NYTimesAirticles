//
//  RowViewModel.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import Foundation

struct APIResponse : Codable{
    var results : [RowViewModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        results = [RowViewModel]()
        if let value = try? container.decode([RowViewModel].self, forKey: .results){
            results = value
        }
    }
}
struct RowViewModel: Codable {
    var articleUrl: String
    var title: String
    var abstract: String
    var publishedDate: String
    var byLine: String
    var media: [Media]
    init() {
        articleUrl      = ""
        title           = ""
        abstract        = ""
        publishedDate   = ""
        byLine          = ""
        media           = [Media]()
        
    }
    private enum CodingKeys: String, CodingKey {
        case articleUrl = "url"
        case title
        case abstract
        case publishedDate  = "published_date"
        case byLine         = "byline"
        case media
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        articleUrl = ""
        if let value = try? container.decode(String.self, forKey: .articleUrl){
            articleUrl = value
        }
        
        title = ""
        if let value = try? container.decode(String.self, forKey: .title){
            title = value
        }
        
        abstract = ""
        if let value = try? container.decode(String.self, forKey: .abstract){
            abstract = value
        }
        
        publishedDate = ""
        if let value = try? container.decode(String.self, forKey: .publishedDate){
            publishedDate = value
        }
        
        byLine = ""
        if let value = try? container.decode(String.self, forKey: .byLine){
            byLine = value
        }
        
        media = [Media]()
        if let value = try? container.decode([Media].self, forKey: .media){
            media = value
        }
    }
}

struct Media: Codable {
    var metaData: [MediaMetaData]
    private enum CodingKeys: String, CodingKey {
        case metaData = "media-metadata"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = [MediaMetaData]()
        if let value = try? container.decode([MediaMetaData].self, forKey: .metaData){
            metaData = value
        }
    }
}

struct MediaMetaData: Codable {
    var url: String
    
//    private enum CodingKeys: String, CodingKey {
//        case url
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = ""
        if let value = try? container.decode(String.self, forKey: .url){
            url = value
        }
    }
}

