import UIKit
import CoreLocation

// CLLocationManagerDelegateを継承しなければならない
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // 現在地の位置情報の取得にはCLLocationManagerを使用
    let lm = CLLocationManager()
    // 取得した緯度を保持するインスタンス
    let latitude = CLLocationDegrees()
    // 取得した経度を保持するインスタンス
    let longitude = CLLocationDegrees()
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 - 20, 200, 40))
        btn.backgroundColor = UIColor.blueColor()
        btn.titleLabel?.text = "Stop"
        btn.titleLabel?.textColor = UIColor.whiteColor()
        btn.addTarget(self, action:"stop", forControlEvents: .TouchDown)
        self.view.addSubview(btn)
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        // lm.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        // lm.distanceFilter = 1000
        
        // GPSの使用を開始する
        
    }
    
    func stop() {
        if i % 2 == 0 {
            lm.startUpdatingLocation()
        } else {
            lm.stopUpdatingLocation()
        }
        i += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        let lat = newLocation.coordinate.latitude
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        let long = newLocation.coordinate.longitude
        // 取得した緯度・経度をLogに表示
        print("latiitude: \(lat) , longitude: \(long)")
        
        // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
        // lm.stopUpdatingLocation()
    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // この例ではLogにErrorと表示するだけ．
        print("Error")
    }
    
}