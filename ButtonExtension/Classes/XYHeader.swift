//
//  XYHeader.swift
//  GuangJiePlayer
//
//  Created by zyfMac on 2022/11/7.
//

import Foundation
import UIKit

typealias ButtonAction = (_ sender:UIButton)->()

extension UIButton{
    
    ///给 button 添加一个属性 用于记录点击的 tag
    private struct AssociatedKeys{
        static var actionKey = "UIButton+LRS+ActionKey"
    }
    @objc dynamic var actionDic: NSMutableDictionary? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let dic = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? NSDictionary{
                return NSMutableDictionary.init(dictionary: dic)
            }
            return nil
        }
    }
    ///添加对应状态下的点击事件
    @objc dynamic func addTouchAction(action:@escaping  ButtonAction ,for controlEvents: UIControl.Event) {
        
        let eventStr = NSString.init(string: String.init(describing: controlEvents.rawValue))
        if let actions = self.actionDic {
            actions.setObject(action, forKey: eventStr)
            self.actionDic = actions
        }else{
            self.actionDic = NSMutableDictionary.init(object: action, forKey: eventStr)
        }
        
        switch controlEvents {
        case .touchUpInside:
            
            self.addTarget(self, action: #selector(touchUpInSideAction), for: .touchUpInside)
            
        case .touchUpOutside:
            
            self.addTarget(self, action: #selector(touchUpOutsideAction), for: .touchUpOutside)
        
        case .valueChanged:
            
            self.addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
            ///可以继续添加 其他状态下的点击事件……
        default:
            
            self.addTarget(self, action: #selector(touchUpInSideAction), for: .touchUpInside)
        }
    }
    
    
    @objc fileprivate func touchUpInSideAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? ButtonAction{
                touchUpInSideAction(self)
            }
        }
    }
    
    @objc fileprivate func touchUpOutsideAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideButtonAction = actionDic.object(forKey:   String.init(describing: UIControl.Event.touchUpOutside.rawValue)) as? ButtonAction{
                touchUpOutsideButtonAction(self)
            }
        }
    }
    
    @objc fileprivate func valueChangedAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideButtonAction = actionDic.object(forKey:   String.init(describing: UIControl.Event.valueChanged.rawValue)) as? ButtonAction{
                touchUpOutsideButtonAction(self)
            }
        }
    }
    
    ///快捷调用 事件类型为 .touchUpInside
    @objc func add_Action(_ action:@escaping ButtonAction){
        self.addTouchAction(action: action, for: .touchUpInside)
    }
    
    
    ///这俩方法就比较的牛了 让每一个点击事件都返回自身，为链式调用做准备
    @discardableResult
    func addTouchUpInSideButtonAction(_ action:@escaping ButtonAction) -> UIButton{
        self.addTouchAction(action: action, for: .touchUpInside)
        return self
    }
    
    @discardableResult
    func addTouchUpOutSideButtonAction(_ action:@escaping ButtonAction) -> UIButton{
        self.addTouchAction(action: action, for: .touchUpOutside)
        return self
    }
    
}
