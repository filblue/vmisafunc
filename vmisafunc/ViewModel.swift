//
//  ViewModel.swift
//  vmisafunc
//

import Foundation
import UIKit
import ReactiveCocoa

struct Presenters {
    let presentImage: UIImage -> ()
    let presentOnTextChanged: (String? -> ()) -> Disposable
}

struct Model {
    let imageLoader: (Int, success: UIImage -> ()) -> Disposable
}


typealias ViewModel = Presenters -> Disposable


func viewModelWith(model: Model) -> ViewModel {
    
    return { presenters in
    
        let serial = SerialDisposable()
        
        let disposable = CompositeDisposable()
        disposable += serial
        
        disposable += presenters.presentOnTextChanged { text in
            if let string = text, index = Int(string) {
                serial.innerDisposable = model.imageLoader(index, success: presenters.presentImage)
            }
        }
        
        return disposable
    }
}

// M -> VM
// M -> (P -> D)

