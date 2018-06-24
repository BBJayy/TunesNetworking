//
//  QueryService.swift
//  HalfTunes
//
//  Created by Рома Сорока on 20.06.2018.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import Foundation

// Downloads song snippets, and stores in local file.
// Allows cancel, pause, resume download.
class DownloadService {

  var activeDownloads: [URL: Download] = [:]
  
  // SearchViewController creates downloadsSession
  var downloadsSession: URLSession!

  // MARK: - Download methods called by TrackCell delegate methods

  func startDownload(_ track: Track) {
    let download = Download(track: track)
    download.task = downloadsSession.downloadTask(with: track.previewUrl)
    download.task!.resume()
    download.isDownloading = true
    activeDownloads[download.track.previewUrl] = download
  }
  
  // TODO: previewURL is http://a902.phobos.apple.com/...
  // why doesn't ATS prevent this download?

  func pauseDownload(_ track: Track) {
    guard let download = activeDownloads[track.previewUrl] else { return }
    if download.isDownloading {
      download.task?.cancel(byProducingResumeData: { data in
        download.resumeData = data
      })
      download.isDownloading = false
    }
  }

  func cancelDownload(_ track: Track) {
    if let download = activeDownloads[track.previewUrl] {
      download.task?.cancel()
      activeDownloads[track.previewUrl] = nil
    }
  }

  func resumeDownload(_ track: Track) {
    guard let download = activeDownloads[track.previewUrl] else { return }
    if let resumeData = download.resumeData {
      download.task = downloadsSession.downloadTask(withResumeData: resumeData)
    } else {
      download.task = downloadsSession.downloadTask(with: download.track.previewUrl)
    }
    download.task!.resume()
    download.isDownloading = true
  }
}
