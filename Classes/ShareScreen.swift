//  ScreenShot
//  Includes
//  1) Capture Screenshot and Share
//  2) Share Screenshot by Passing Image
//  3) Share Text by Passing Text
//  4) Capture Screenshot and Share with Callback
//  Remove the obj C Code if there is no dependency between the Objective C

import UIKit

@objc(ShareScreeen)
public class ShareScreeen: UIViewController {
    
    //Take Screen Shot and Share Across App Without CallBack
    @objc(shareScreenShot)
    public func shareScreenShot() -> Bool{
        var isSuccess:Bool = false
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        if let screenshot = UIGraphicsGetImageFromCurrentImageContext() {
            let imageToShare = [screenshot]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                DispatchQueue.main.async {  topController.present(activityViewController, animated: true, completion: nil)}
            }
            isSuccess = true
        }
        return isSuccess
    }
    
    //Share Image by Passing Image
    @objc(shareImage:)
    public func shareImage(screenshot:UIImage? = nil) ->  Bool {
        var isSuccess:Bool = false
        if let screenshot = screenshot {
            let imageToShare = [screenshot]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                topController.present(activityViewController, animated: true, completion: nil)
                isSuccess = true
            }
        }
        return isSuccess
    }
    
    //Share Text by Passing Text
    @objc(shareText:)
    public func shareText(text:String? = nil) ->  Bool {
        var isSuccess:Bool = false
        if let text = text {
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                topController.present(activityViewController, animated: true, completion: nil)
                isSuccess = true
            }
        }
        return isSuccess
    }
    
    
    //Take Screen Shot and Share Across App With CallBack
    public func shareImageWithCallBack(success: @escaping (_ value: Bool) -> Void, onFailure failure: @escaping (_ value: Bool) -> Void) -> () {
        //var isSuccess:Bool = false
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        if let screenshot = UIGraphicsGetImageFromCurrentImageContext() {
            self.shareCallBack(image: screenshot, onSuccess: { (value) in
                success(value)
            },onFailure: { (value) in
                failure(value)
            })
        }
        else { failure(false) }
    }
    
    public func shareCallBack(image: UIImage, onSuccess success: @escaping (_ value: Bool) -> Void, onFailure failure: @escaping (_ value: Bool) -> Void) {
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed  { success(completed) }
            else { failure(completed) }
        }
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            DispatchQueue.main.async {  topController.present(activityViewController, animated: true, completion: nil)}
        }
    }
    
    
}


