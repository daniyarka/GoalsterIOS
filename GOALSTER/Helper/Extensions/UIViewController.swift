//
//  UIViewCOntroller.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

var textViewToClose: UITextView?

extension UIViewController {    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func addBackButton(){
        let backImage = UIImage(named: "backButton")!.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView.init(image: backImage)
        let backView = UIView()
        backView.addSubview(imageView)
        imageView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(StaticSize.size(10))
            $0.height.equalTo(StaticSize.size(18))
        })
        let menuItem = UIBarButtonItem(customView: backView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pop))
        backView.addGestureRecognizer(tapGesture)
        let widthConstraintLeft = backView.widthAnchor.constraint(equalToConstant: 40)
        let heightConstraintLeft = backView.heightAnchor.constraint(equalToConstant: 40)
        heightConstraintLeft.isActive = true
        widthConstraintLeft.isActive = true
        menuItem.imageInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    @objc func pop(){
        navigationController?.popViewController(animated: true)
    }

//  MARK: - Modal opening

    @objc func openTimeModal(){
        openModal(vc: TimeModalViewController(modalHeight: ScreenSize.SCREEN_HEIGHT / 3))
    }
    
    @objc func openSphereModal(){
        openModal(vc: SphereModalViewController(modalHeight: ScreenSize.SCREEN_HEIGHT / 3))
    }
    
    @objc func openLanguagesModal(){
        openModal(vc: LanguagesModalViewController(modalHeight: ScreenSize.SCREEN_HEIGHT / 3))
    }
    
    func openModal(vc: CustomModalViewController){
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.openContainer()
    }
    
    func openTop(vc: UIViewController){
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(view.snp.right).priority(.low)
            $0.width.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.view.snp.makeConstraints({
            $0.left.equalToSuperview().priority(.medium)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func removeTop(){
        if let superview = view.superview{
            view.snp.makeConstraints({
                $0.top.bottom.equalToSuperview()
                $0.left.equalTo(superview.snp.right).priority(.high)
                $0.width.equalToSuperview()
            })
            
            UIView.animate(withDuration: 0.15, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                self.remove()
            })
        }
    }
    
//  MARK: - Keyboard opening
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround(textView: UITextView) {
        textViewToClose = textView
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTextView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardTextView() {
        textViewToClose?.resignFirstResponder()
    }
    
    func keyboardDisplay(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if window.frame.origin.y == 0
            {
                window.frame.origin.y -= (keyboardSize.height - StaticSize.size(20))
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            if window.frame.origin.y != 0
            {
                window.frame.origin.y += (keyboardSize.height - StaticSize.size(20))
            }
        }
    }
    
    func disableKeyboardDisplay(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func showAlert(title: String?, messsage: String? = nil, yesCompletion: ((UIAlertAction) -> Void)? = nil, noCompletion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes".localized, style: .default, handler: yesCompletion)
        let noAction = UIAlertAction(title: "No".localized, style: .default, handler: noCompletion)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
}
