//
//  ViewController.swift
//  StampPittan
//
//

import UIKit

class ViewController: UIViewController {

    var currentStampNo:Int = 0
    
    @IBOutlet weak var stampBaseView: UIView!
    
    @IBOutlet var stamps: [UIImageView]!
    
    // スタンプリセット
    @IBAction func stampReset(_ sender:UIButton) {
        
        let _ = stamps.map { $0.isHidden = true }
        currentStampNo = 0
    }

    // スタンプ押す
    @IBAction func stampAdd(_ sender:UIButton) {

        if currentStampNo < stamps.count {
            doStamp(stamp: stamps[currentStampNo] )
            currentStampNo += 1
        } else {
            let alert = UIAlertView()
            alert.title = "Stamp Demo"
            alert.message = "もういぱいです！"
            alert.addButton(withTitle: "OK")
            alert.show()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // スタンプ初期化
        let _ = stamps.map { $0.isHidden = true }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // スタンプ台を揺らす。amount = 揺れ幅
    func vibrate(amount: Float ,view: UIView) {
        if amount > 0 {
            var animation: CABasicAnimation
            animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = 0.1
            animation.fromValue = amount * Float(M_PI) / 180.0
            animation.toValue = 0 - (animation.fromValue as! Float)
            animation.repeatCount = 1.0
            animation.autoreverses = true
            view.layer .add(animation, forKey: "VibrateAnimationKey")
        }
        else {
            view.layer.removeAnimation(forKey: "VibrateAnimationKey")
        }
    }
    
    // スタンプ押下
    func doStamp(stamp:UIImageView) {
        
        // 透明にする
        stamp.alpha = 0.0
        // 表示
        stamp.isHidden = false
        // サイズと位置情報
        let b = stamp.bounds
        
        UIView.animate(withDuration: 0.05,
                       delay:0.0,
                       usingSpringWithDamping:0.2,
                       initialSpringVelocity:10,
                       options:[],animations:{
                            // サイズを大きくする
                            stamp.bounds = CGRect(x:b.origin.x,
                                                  y:b.origin.y,
                                                  width:b.size.width + 130,
                                                  height:b.size.height + 130)
                        },
                        completion: nil)
        
        
         UIView.animate(withDuration: 0.05,
                        delay: 0.8,
                        usingSpringWithDamping: 1.0,
                        initialSpringVelocity: 90,
                        options: [], animations: {
                            // サイズを元に戻す
                            stamp.bounds = CGRect(x:b.origin.x,
                                                  y:b.origin.y,
                                                  width:b.size.width,
                                                  height:b.size.height)
                            // 透過度を元に戻す
                            stamp.alpha = 1.0
                        },
                        completion:{ finished in
                            // 台紙を揺らす
                            self.vibrate(amount: 3.0 ,view: self.stampBaseView)
                        })
    }

}

