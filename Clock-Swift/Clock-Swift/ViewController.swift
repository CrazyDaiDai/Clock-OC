//
//  ViewController.swift
//  Clock-Swift
//
//  Created by 呆仔～林枫 on 2017/7/21.
//  Copyright © 2017年 Lin_Crazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let secView = UIView.init()///秒
    let minuteView = UIView.init()///分
    let hourView = UIView.init()///时
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagePath = Bundle.main.path(forResource: "clock", ofType: "png")
        let imageView = UIImageView.init(image: UIImage(contentsOfFile: imagePath!))
        view.addSubview(imageView)
        imageView.bounds = CGRect.init(x: 0, y: 0, width: 150, height: 150)
        imageView.center = view.center
        setUI()
        let link = CADisplayLink.init(target: self, selector: #selector(updateTime))
        link.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }

    func setUI() {//可以写成懒加载 关键词 lazy
        ///秒,分,时
        view.addSubview(secView)
        secView.backgroundColor = .red
        secView.bounds = CGRect.init(x: 0, y: 0, width: 60, height: 1)
        secView.center = view.center
        secView.layer.anchorPoint = CGPoint.init(x: 0, y: 0.5)
        
        view.addSubview(minuteView)
        minuteView.backgroundColor = .black
        minuteView.bounds = CGRect.init(x: 0, y: 0, width: 45, height: 2)
        minuteView.center = view.center
        minuteView.layer.anchorPoint = CGPoint.init(x: 0, y: 0.5)
        
        view.addSubview(hourView)
        hourView.backgroundColor = .black
        hourView.bounds = CGRect.init(x: 0, y: 0, width: 35, height: 3)
        hourView.center = view.center
        hourView.layer.anchorPoint = CGPoint.init(x: 0, y: 0.5)
    }
    
    func updateTime() {
        
        //获取时区
        let timeZ = NSTimeZone.local
        //获取日历
        var calendar = NSCalendar.current
        //获取时间
        let date = Date()
        //设置日历的时区
        calendar.timeZone = timeZ
        //取出时分秒
        let currentTime : DateComponents = calendar.dateComponents([Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: date)
        //设置指针的角度
        let secAngle = CGFloat(.pi * 2 / 60 * Double(currentTime.second!))
        let minuteAngle = CGFloat(.pi * 2 / 60 * Double(currentTime.minute!))
        let hourAngle = CGFloat(.pi * 2 / 12 * Double(currentTime.hour!))
        
//        secView
//        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15, options: .layoutSubviews, animations: {
//            self.secView.transform = CGAffineTransform.init(rotationAngle: secAngle)
//        }, completion: nil)
        UIView.animate(withDuration: 1.0) {
            self.secView.transform = CGAffineTransform.init(rotationAngle: secAngle - .pi / 2)
        }
//        minuteView
        minuteView.transform = CGAffineTransform.init(rotationAngle: minuteAngle - .pi / 2 + .pi * 2 / 60 / (.pi * 2 / secAngle))
//        hourView
        hourView.transform = CGAffineTransform.init(rotationAngle: hourAngle - .pi / 2 + .pi * 2 / 12 / (.pi * 2 / minuteAngle))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

