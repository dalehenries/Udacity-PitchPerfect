//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dale Henries on 11/9/15.
//  Copyright © 2015 Samaritan's Purse. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        } catch {
            NSLog("Error creating audioPlayer")
        }
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    @IBAction func playSlow(sender: UIButton) {
        // TODO: play recording slow
        playAtRate(0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        playAtRate(2.0)
    }

    @IBAction func stopPlayer(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playWithPitch(1000)
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playWithPitch(-1000)
    }
    
    func playAtRate(rate: Float) {
        stopPlayer(self)
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playWithPitch(pitch: Float) {
        stopPlayer(self)
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
}
