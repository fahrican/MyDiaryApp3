//
//  AudioViewController.swift
//  MyDiaryApp3
//
//  Created by fahri on 27.12.18.
//  Copyright © 2018 fahri. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fileMgr = FileManager.default
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("my_audio.caf")
        let audioSession = AVAudioSession.sharedInstance()
        
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
                              AVEncoderBitRateKey: 16,
                              AVNumberOfChannelsKey: 2,
                              AVSampleRateKey: 44100.0] as [String: Any]
        
        do{
            try
                audioSession.setCategory(.playAndRecord, mode: .default)
            
        }
        catch let error as NSError {
            
            print(error)
        }
        
        do {
            try
                audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings as [String: AnyObject])
            
            audioRecorder?.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
  
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            audioRecorder?.record()
        }
    }
    
    
    @IBAction func stopAudio(_ sender: Any) {
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
}
