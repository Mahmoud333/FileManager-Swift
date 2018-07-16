//
//  DropShadow+Protocol.swift
//  Pods
//
//  Created by Mahmoud Hamad on 7/16/17.
//
//

import UIKit

protocol DropShadow{}

extension DropShadow where Self: UIView {
    
    func addDropShadowSMGL(){
        let SHADOW_GRAY: CGFloat = 120.0/255.0 //Color For Shadow
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0 //How far it blurs out / shadow spans out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0) //ta5od curve lt7t
    }
}


class FancyView: UIView, DropShadow {
    
    @IBInspectable var addShadow: Bool = false {
        didSet {
            if addShadow == true {
                addDropShadowSMGL()
            }
        }
    }
}
