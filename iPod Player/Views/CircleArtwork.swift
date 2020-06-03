//
//  CircleArtwork.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 6/1/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
class CircularProgressView: UIView {
    var progressLyr = CAShapeLayer()
    var trackLyr = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCircularPath()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = UIColor.darkGray.cgColor
        trackLyr.lineWidth = 5.0
        trackLyr.strokeEnd = 1.0
        layer.addSublayer(trackLyr)
        progressLyr.path = circlePath.cgPath
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = UIColor.lightGray.cgColor
        progressLyr.lineWidth = 5.0
        progressLyr.strokeEnd = 0.0
        layer.addSublayer(progressLyr)
    }
    func setProgressWithAnimation(duration: TimeInterval, value: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.timeOffset = value
        animation.toValue = 1.0
        animation.fillMode = .both
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLyr.strokeEnd = CGFloat(value/duration)
        progressLyr.add(animation, forKey: "animateprogress")
    }
    
    func setColor() {
        trackLyr.strokeColor = Theme.currentTheme().bgColor.cgColor
        progressLyr.strokeColor = Theme.currentTheme().borderColor.cgColor
    }
    
    func pauseProgress() {
        let layer = self.progressLyr
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        print("pausedTime= \(pausedTime)")
        
    }
    
    func resumeProgress() {
        let layer = self.progressLyr
        let pausedTime = layer.timeOffset
        print("pausedTime= \(pausedTime)")
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        print("cureent = \(layer.convertTime(CACurrentMediaTime(), from: nil))")
        print("timeSincePause= \(timeSincePause)")
        layer.beginTime = timeSincePause
    }
}
