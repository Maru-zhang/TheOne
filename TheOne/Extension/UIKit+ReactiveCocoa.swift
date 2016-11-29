
//
//  Util.swift
//  ReactiveTwitterSearch
//
//  Created by Colin Eberhardt on 10/05/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

struct AssociationKey {
    static var hidden: UInt8 = 1
    static var alpha: UInt8 = 2
    static var text: UInt8 = 3
    static var image: UInt8 = 4
    static var on: UInt8 = 5
    static var enabled: UInt8 = 6
    static var selected: UInt8 = 7
}

// lazily creates a gettable associated property via the given factory
func lazyAssociatedProperty<T: AnyObject>(host: AnyObject, key: UnsafeRawPointer, factory: ()->T) -> T {
  var associatedProperty = objc_getAssociatedObject(host, key) as? T
  
  if associatedProperty == nil {
    associatedProperty = factory()
    objc_setAssociatedObject(host, key, associatedProperty, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
  return associatedProperty!
}

func lazyMutableProperty<T>(host: AnyObject, key: UnsafeRawPointer, setter: @escaping (T) -> (), getter: @escaping () -> T) -> MutableProperty<T> {
  return lazyAssociatedProperty(host: host, key: key) {
    let property = MutableProperty<T>(getter())
    property.producer
      .startWithValues { newValue in
        setter(newValue)
      }
    return property
  }
}


extension UIViewController {
    
    func isActive() -> SignalProducer<Bool, NoError> {
        
        // Track whether view is visible
        
        let viewWillAppear = rac_signalForSelector(#selector(viewWillAppear(_:))).toSignalProducer()
        let viewWillDisappear = rac_signalForSelector(#selector(viewWillDisappear(_:))).toSignalProducer()
        
        let viewIsVisible = SignalProducer(values: [
            viewWillAppear.map { _ in true },
            viewWillDisappear.map { _ in false }
            ]).flatten(.Merge)
        
        // Track whether app is in foreground
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        let didBecomeActive = notificationCenter
            .rac_addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil)
            .toSignalProducer()
        
        let willBecomeInactive = notificationCenter
            .rac_addObserverForName(UIApplicationWillResignActiveNotification, object: nil)
            .toSignalProducer()
        
        let appIsActive = SignalProducer(values: [
            SignalProducer(value: true), // Account for app being initially active without notification
            didBecomeActive.map { _ in true },
            willBecomeInactive.map { _ in false }
            ]).flatten(.Merge)
        
        // View controller is active iff both are true:
        
        return combineLatest(viewIsVisible, appIsActive)
            .map { $0 && $1 }
            .flatMapError { _ in SignalProducer.empty }
    }
}

extension UIView {
  public var rac_alpha: MutableProperty<CGFloat> {
    return lazyMutableProperty(self, key: &AssociationKey.alpha, setter: { self.alpha = $0 }, getter: { self.alpha  })
  }
  
  public var rac_hidden: MutableProperty<Bool> {
    return lazyMutableProperty(self, key: &AssociationKey.hidden, setter: { self.hidden = $0 }, getter: { self.hidden  })
  }
}

extension UIImageView {
  public var rac_image: MutableProperty<UIImage?> {
    return lazyMutableProperty(self, key: &AssociationKey.image, setter: { self.image = $0 }, getter: { self.image })
  }
}

extension UILabel {
  public var rac_text: MutableProperty<String> {
    return lazyMutableProperty(self, key: &AssociationKey.text, setter: { self.text = $0 }, getter: { self.text ?? "" })
  }
}

extension UITextField {
  public var rac_text: MutableProperty<String> {
    return lazyAssociatedProperty(self, key: &AssociationKey.text) {
      
      self.addTarget(self, action: #selector(UITextField.changed), forControlEvents: UIControlEvents.EditingChanged)
      
      let property = MutableProperty<String>(self.text ?? "")
      property.producer
        .startWithNext { newValue in
          self.text = newValue
        }
      return property
    }
  }
  
  func changed() {
    rac_text.value = self.text!
  }
}

extension UISearchBar: UISearchBarDelegate {
    
    public var rac_text: MutableProperty<String> {
        return lazyAssociatedProperty(host: self, key: &AssociationKey.text) {
            
            self.delegate = self
            
            let property = MutableProperty<String>(self.text ?? "")
            property.producer
                .startWithValues { newValue in
                    self.text = newValue
            }
            return property
        }
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        rac_text.value = searchBar.text!
    }
}

extension UISwitch {
    public var rac_on: MutableProperty<Bool> {
        return lazyAssociatedProperty(host: self, key: &AssociationKey.on) {
            
            self.addTarget(self, action: #selector(UITextField.changed), for: UIControlEvents.valueChanged)
            
            let property = MutableProperty<Bool>(self.isOn)
            property.producer
                .startWithValues { newValue in
                    self.isOn = newValue
            }
            return property
        }
    }
    
    func changed() {
        rac_on.value = self.isOn
    }
}

extension UIButton {
    public var rac_enabled: MutableProperty<Bool> {
        return lazyMutableProperty(host: self, key: &AssociationKey.enabled, setter: { self.isEnabled = $0 }, getter: { self.isEnabled })
    }
}

extension UIButton {
    public var rac_selected: MutableProperty<Bool> {
        return lazyMutableProperty(host: self, key: &AssociationKey.selected, setter: {self.isSelected = $0}, getter: { self.isSelected })
    }
}

