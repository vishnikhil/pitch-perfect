//
//  RecordedAudio.swift
//  AudioPlayer
//
//  Created by Vishruti Kekre on 12/15/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl : NSURL!
    var title : String!
    
//    Add a Constructor to initialize the properties
    init(filePathUrl:NSURL,title:String){
           self.filePathUrl = filePathUrl
           self.title = title
           }
    
}
