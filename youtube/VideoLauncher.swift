//
//  VideoLauncher.swift
//  youtube
//
//  Created by Jorge Casariego on 1/9/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        
        //Si vamos a agregar algun constraint a alguna de las vistas debemos agregar esto
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .System)
        let image = UIImage(named: "pause")
        button.setImage(image, forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .whiteColor()
        button.hidden = true
        
        button.addTarget(self, action: #selector(handlePause), forControlEvents: .TouchUpInside)
        return button
    }()
    
    
    var isPlaying = false
    
    func handlePause() {
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), forState: .Normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), forState: .Normal)
        }
        
        
        
        isPlaying = !isPlaying
    }
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .whiteColor()
        label.font = UIFont.boldSystemFontOfSize(14)
        label.textAlignment = .Right
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .redColor()
        slider.maximumTrackTintColor = .whiteColor()
        slider.setThumbImage(UIImage(named: "thumb"), forState: .Normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), forControlEvents: .ValueChanged)
        return slider
    }()
    
    func handleSliderChange() {
        print(videoSlider.value)
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            //Esto hace que nos movamos "value" segundos en el video
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seekToTime(seekTime, completionHandler: { (completedSeek) in
                //
            })

        }
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        activityIndicatorView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        pausePlayButton.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        pausePlayButton.widthAnchor.constraintEqualToConstant(50).active = true
        pausePlayButton.heightAnchor.constraintEqualToConstant(50).active = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -8).active = true
        videoLengthLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        videoLengthLabel.widthAnchor.constraintEqualToConstant(60).active = true
        videoLengthLabel.heightAnchor.constraintEqualToConstant(20).active = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraintEqualToAnchor(videoLengthLabel.leftAnchor).active = true
        videoSlider.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        videoSlider.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        videoSlider.heightAnchor.constraintEqualToConstant(30).active = true
        
        
        
        backgroundColor = UIColor.blackColor()
        
    }
    
    var player: AVPlayer?
    
    private func setupPlayerView() {
        let urlString = "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"
        if let url = NSURL(string: urlString) {
            player = AVPlayer(URL: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            //Para saber cuando el video esta listo para mostrarse debemos utilizar un Observer
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .New, context: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //Aqui entra cuando el video esta listo para mostrarse, entonces es el momento de parar el indicator
        if keyPath == "currentItem.loadedTimeRanges" {
            //print(change)
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clearColor()
            pausePlayButton.hidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing a video player with animation")
        
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.whiteColor()
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 x 9 is the aspect radio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
                
                }, completion: { (completed) in
                    //We'll do something here later
                    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
                    
            })
        }
    }
}
