//
//  Track.swift
//  HalfTunes
//
//  Created by Рома Сорока on 20.06.2018.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import Foundation

// Query service creates Track objects
class Track {
  let trackName: String
  let artistName: String
  let previewUrl: URL
  let index: Int
  var downloaded = false
  
  init(name: String, artist: String, previewUrl: URL, index: Int) {
    self.trackName = name
    self.artistName = artist
    self.previewUrl = previewUrl
    self.index = index
  }
  
}
