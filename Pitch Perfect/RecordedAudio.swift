//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Dale Henries on 11/9/15.
//  Copyright © 2015 Dale Henries. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}