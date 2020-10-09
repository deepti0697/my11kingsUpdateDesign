//
//  CellReusable.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import Foundation
import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

internal protocol CellReusable {
    static func identifier() -> String
}

internal extension CellReusable where Self: UIView {
    static func identifier() -> String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: CellReusable, NibLoadableView { }
extension UITableViewHeaderFooterView: CellReusable, NibLoadableView { }
extension UICollectionViewCell: CellReusable, NibLoadableView { }

//extension UITableView {
//    
//    func register<T: UITableView>(_: T.Type) {
//        register(T.self, forCellWithReuseIdentifier: T.identifier())
//    }
//    
//    func registerNib<T: UITableView>(_: T.Type) {
//        let bundle = Bundle(for: T.self)
//        let nib = UINib(nibName: T.nibName, bundle: bundle)
//        
//        register(nib, forCellWithReuseIdentifier: T.identifier())
//    }
//    
//    func dequeueReusableCell<T: UITableView>(for indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier(), for: indexPath) as? T else {
//            fatalError("Could not dequeue cell with identifier: \(T.identifier())")
//        }
//        
//        return cell
//    }
//}


extension UICollectionView {
    
    func makeItemSelected(atIndexPath indexPath: IndexPath) {
        self.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        self.delegate?.collectionView!(self, didSelectItemAt: indexPath)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier())
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.identifier())
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier(), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier())")
        }
        
        return cell
    }
}
