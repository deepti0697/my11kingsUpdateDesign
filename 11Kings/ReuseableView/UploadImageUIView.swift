//
//  UploadImageUIView.swift
//  11Kings
//
//  Created by uu on 12/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class UploadImageUIView: UIView,URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate  {

    @IBOutlet weak var imageUploadProgressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
  
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
      {
        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        imageUploadProgressView.progress = uploadProgress
          let progressPercent = Int(uploadProgress*100)
          progressLabel.text = "\(progressPercent)%"
          
      }

}
