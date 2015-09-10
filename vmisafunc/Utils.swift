//
//  Helpers.swift
//  vmisafunc
//

import Foundation
import UIKit
import ReactiveCocoa

func downloadXCKDImage(index: Int, success: UIImage -> ()) -> Disposable {
    
    var task1: NSURLSessionDataTask?
    
    let url = "https://xkcd.com/\(index)/"
    let task0 = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { data, _, _ in

        let imageURL: String? = data
            .flatMap { String(data: $0, encoding: NSUTF8StringEncoding) }
            .flatMap { page -> String? in
                let c0 = page.componentsSeparatedByString("Image URL (for hotlinking/embedding): ")
                if (c0.count > 1) {
                    let c1 = c0[1].componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                    if (c1.count > 0) {
                        return c1[0]
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
                
        }
        task1 = imageURL
            .flatMap { NSURL(string: $0) }
            .map {
                NSURLSession.sharedSession().dataTaskWithURL($0, completionHandler: {  data, _, e in
                    if let image = data.flatMap( { UIImage(data: $0) } ) {
                        dispatch_async(dispatch_get_main_queue()) {
                            success(image)
                        }
                    }
                })
            }
            
        task1?.resume()
    })
    
    task0.resume()
    
    return ActionDisposable {
        task0.cancel()
        task1?.cancel()
    }
}