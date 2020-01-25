//
//  ViewController.swift
//  MusicPlayer_iOS
//
//  Created by Misun Joo on 14/01/2020.
//  Copyright © 2020 Misun Joo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var player: AVAudioPlayer!
    var timer: Timer!
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializePlayer()
    }
    
    // initializePlayer() : player를 초기화해주는 함수
    // asset에서 sound data 가져오기
    func initializePlayer() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원파일을 가져올 수 없습니다.")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data : soundAsset.data)
            self.player.delegate = self
        } catch let err as NSError {
            print("Fails Player initialize")
            print("Codes : \(err.code), message : \(err.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }

    // updateTimeLabelText() : slider의 값에 따라서 label의 text를 변경하는 함수
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60)) //부동소수점의 나머지 연산
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        timeLabel.text = timeText
    }

    // makeAndFireTimer() : timer의 실행에 관여하는 함수
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {[unowned self] (timer: Timer) in
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value =  Float(self.player.currentTime)
            
        })
    }

    // invalidateTimer() : timer 비활성화
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }

    // addViewWithCode() : Layout을 코드로 관여

    // addPlayPauseButton() : button의 auto-layout에 관여
    func addPlayPauseButton() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)

        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)

        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
    }

    // addTimeLabel() : label의 auto-layout에 관여

    // addProgressSlider() : slider의 auto-layout에 관여, slider 초기화
    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        slider.minimumTrackTintColor = UIColor.red
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        self.progressSlider = slider
    }

    // @IBAction touchUpPlayPauseButton() : play버튼을 눌렀을 때
    
    // isSelected의 속성은 항상 false라 개발자가 지정해줘야 한다
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.player.play()
        } else {
            self.player.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        }
    }
    
    // @IBAction sliderValueChanged() : slider value가 변할 때
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if sender.isTracking {return}
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    // audioPlayerDecodeErrorDidOccur() : 플레이어 디코드 오류가 발생했을 때


    // audioPlayerDidFinishPlaying() : 플레이어가 마쳤을 때
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        
    }
}

//https://baked-corn.tistory.com/104
