//
//  ItemsCache.swift
//  TheHat
//
//  Created by Christopher Papa on 11/13/20.
//

import SwiftUI
import Combine

class Cache: ObservableObject {

    static var defaultItems = [Item(name: "Chris"),
                               Item(name: "Saharsh"),
                               Item(name: "Santosh"),
                               Item(name: "Sunil"),
                               Item(name: "Daniel")].sorted(by: >)
    
    
    // MARK: - Handle First Load

    static var isFirstLoad: Bool {
        get {
            UserDefaults.standard.bool(for: .firstLoadKey)
        }
        set {
            UserDefaults.standard.set(newValue, for: .firstLoadKey)
        }
    }
    
    static func appDidLoad() {
        guard isFirstLoad else { return }
        UserDefaults.standard.set(defaultItems, for: .itemsKey)
        isFirstLoad = false
    }
    
    // MARK: - Methods
    
    @Published var items: [Item] = UserDefaults.standard.objects(for: .itemsKey) {
        didSet {
            UserDefaults.standard.set(items, for: .itemsKey)
        }
    }
    
    @Published var selectedItem: Item? = UserDefaults.standard.object(for: .selectedKey) {
        didSet {
            UserDefaults.standard.set(selectedItem, for: .selectedKey)
        }
    }
    
    // MARK: - Methods
            
    func resetCache() {
        selectedItem = nil
        items = Cache.defaultItems
    }
    
    func pickNext() -> Bool {
        var shouldShowAlert = false
        if let item = items.filter ({ $0.isEligible }).randomElement() {
            selectedItem = item
            update(item, isEligible: false)
            shouldShowAlert = true
        } else {
            resetCache()
            shouldShowAlert = false
        }
        return shouldShowAlert
    }
    
    // MARK: - Add Item
    func addItem(named name: String) {
        items = (items + [Item(name: name)]).sorted(by: >)
    }
    
    
    // MARK: - Remove Item
    
    func remove(_ item: Item) {
        if selectedItem == item {
            selectedItem = nil
        }
        items.removeAll(where: { $0 == item })
    }
    

    
    
    func update(_ item: Item, isEligible: Bool) {
        var copy = item
        copy.isEligible = isEligible
        items.removeAll(where: { $0 == item })
        items = (items + [copy]).sorted(by: >)

    }
}
