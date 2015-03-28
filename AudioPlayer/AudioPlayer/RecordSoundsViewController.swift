//
//  RecordSoundViewController.swift
//  AudioPlayer
//
//  Created by Vishruti Kekre on 12/12/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var TaptoRecord: UILabel!
    
//    func used to hide the stopButton
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true
        recordingInProgress.hidden = true
        TaptoRecord.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function records the Audio
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden=false
        stopButton.hidden=false
        recordButton.enabled = true
        TaptoRecord.hidden = true
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
//    This function shows when recording is done
      func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
            
        if (flag){
//          Call the constructor
            recordedAudio = RecordedAudio(filePathUrl:recorder.url,title:recorder.url.lastPathComponent)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }else{
            println("recording was not successful")
            recordButton.enabled=true
            stopButton.hidden=true
            }
    }
            
    
//    Just called before the segue is about to happen
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
        let playSoundsVC : PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
        let data = sender as RecordedAudio
         playSoundsVC.receivedAudio = data
        }
        
    }
   
    
 //This function stopsRecording the audio
   
       @IBAction func stopRecord(sender: UIButton) {
        audioRecorder.stop()
        
//      SharedInstance returns a singleton audiosession.
//      Deactivating audiosession helps other audiosessions to resume.
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)

    }
    
        
}


