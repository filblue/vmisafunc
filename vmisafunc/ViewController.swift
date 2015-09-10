//
//  ViewController.swift
//  vmisafunc
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.disposable = self.viewModel(Presenters(
            presentImage: self.imageView.presentImage,
            presentOnTextChanged: self.inputField.presentOnEditingChanged
        ))
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.disposable?.dispose()
    }
    
    var disposable: Disposable?
    
    @IBOutlet private weak var inputField: UITextField!
    @IBOutlet private weak var imageView: UIImageView!
}








































extension UITextField {

    class Target: NSObject {

        private static var EditingChangedSelector = Selector("onEditingChanged:")
        
        private init(onEditingChanged: String? -> ()) {
            self.onEditingChanged = onEditingChanged
            super.init()
        }
        
        private let onEditingChanged: String? -> ()

        func onEditingChanged(textField: UITextField) {
            self.onEditingChanged(textField.text)
        }
    }
    
    func presentOnEditingChanged(action: String? -> ()) -> Disposable {
        let target = Target(onEditingChanged: action)

        self.addTarget(target, action: Target.EditingChangedSelector, forControlEvents: UIControlEvents.EditingChanged)
        
        return ActionDisposable {
            self.removeTarget(target, action: Target.EditingChangedSelector, forControlEvents: UIControlEvents.EditingChanged)
        }
    }
}


























extension UIImageView {
    func presentImage(image: UIImage?) {
        self.image = image
    }
}

















