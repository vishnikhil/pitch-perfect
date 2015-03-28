//
//  PlaySoundsViewController.swift
//  AudioPlayer
//
//  Created by Vishruti Kekre on 12/15/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    var audioPlayer2 : AVAudioPlayer!
    var audioPlayer: AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
    audioPlayer.enableRate=true
    audioEngine = AVAudioEngine()
    audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl,error:nil)
    audioPlayer2 = AVAudioPlayer(contentsOfURL : receivedAudio.filePathUrl , error:nil)
       
    }
 
    
    
//    Plays slow Audio
      @IBAction func playSlowAudio(sender: UIButton) {
       stopAudio(sender)
//    The rate property helps us to play the audio slow or fast.
       audioPlayer.rate=0.5
       audioPlayer.play()
        
    }
    
    
//    Plays Fast Audio
      @IBAction func playFastAudio(sender: UIButton) {
//    Call the stopAudio function here.It helps to stop the audio.
      stopAudio(sender)
      audioPlayer.rate=1.5
      audioPlayer.play()
        
    }
    
    
// Stops the Audio
     @IBAction func stopAudio(sender: UIButton) {
       
     audioEngine.stop()
     audioPlayer.stop()
     audioEngine.reset()
     audioPlayer2.stop()
//   CurrentTime property starts the audio from the beginning.
     audioPlayer.currentTime = 0.0
     audioPlayer2.currentTime = 0.0
    
        
    }
    
    
//    Changes the Pitch of the Sound
      func playAudioWithVariablePitch(pitch : Float){
      audioPlayer.stop()
      audioEngine.stop()
      audioEngine.reset()
        
//    AVAudioPlayerNode is connected to our mp3 file
//    and helps us in playing the recorded sound.
      var audioPlayerNode = AVAudioPlayerNode()
      audioEngine.attachNode(audioPlayerNode)
        
//    AVAudioUnitTimePitch class gives a good quality sound and
//    also helps in pitch shifting.
      var changePitchEffect = AVAudioUnitTimePitch()
      changePitchEffect.pitch = pitch
        
      audioEngine.attachNode(changePitchEffect)
      audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
      audioEngine.connect(changePitchEffect,to: audioEngine.outputNode,format:nil)
        
      audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
      audioEngine.startAndReturnError(nil)
      audioPlayerNode.play()
       
    }
    
//    Plays chipmunk effect
      func playChipmunkAudio(pitch : Float) {
      audioPlayer.currentTime = 0.0
      audioPlayer.play()
      playAudioWithVariablePitch(1000)
        
    }

    
//    Plays DarthVader effect
      @IBAction func playDarthsound(sender: UIButton) {
      stopAudio(sender)
      playAudioWithVariablePitch(-1000)
       
    }
    
    
    
//    This function plays an echo effect
//    (Play a delayed copy of our sound with a smaller amplitude).
    
      @IBAction func playEcho(sender: UIButton) {
          
      stopAudio(sender)
      audioPlayer.play()
        
//    NSTimeInterval is used to specify time in seconds.
      let delay : NSTimeInterval = 0.8
      var playtime : NSTimeInterval
      playtime = audioPlayer2.deviceCurrentTime + delay
        
//    audioPlayer2 is the delayed copy of our sound.
      audioPlayer2.volume = 1.0
      audioPlayer2.play()
        
//    The playAtTime method used here helps us to schedule sound.
//      It helps in making echoes and reverbs.
        
      audioPlayer2.playAtTime(playtime)
 
            
            
    }
    
    
//    This func plays an reverb effect
        @IBAction func playReverbButton(sender: UIButton) {
        stopAudio(sender)
        playEffect()

    }
    
    func playEffect(){
    
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
//      Add the reverb effect to the audioEngine before you connect
        var effect = AVAudioUnitReverb()
        audioEngine.attachNode(effect)
        
//      AVAudioUnitDelay implements a delay effect.
//      A delay unit delays the input signal in specific time interval and then blends it with the input signal.
        var effect2 = AVAudioUnitDelay()
        audioEngine.attachNode(effect2)
        audioEngine.connect(audioPlayerNode, to: effect2,format: nil)
        audioEngine.connect(effect2, to:audioEngine.outputNode,format:nil)
        
       audioPlayerNode.scheduleFile(audioFile,atTime:nil,completionHandler:nil)
       audioEngine.startAndReturnError(nil)
       audioPlayerNode.play()
        
        
    }
    
    
}
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
   

