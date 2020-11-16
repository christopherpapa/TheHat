//
//  UserDefaults+Extension.swift
//  TheHat
//
//  Created by Christopher Papa on 11/13/20.
//

import Foundation
import Combine

enum DefaultsKey: String {
    case firstLoadKey, selectedKey, itemsKey
}

extension UserDefaults {
    
    // MARK: - Use Enum Keys
    
    func bool(for key: DefaultsKey) -> Bool {
        bool(forKey: key.rawValue)
    }
    
    func set(_ value: Any?, for key: DefaultsKey) {
        setValue(value, forKey: key.rawValue)
    }
    
    // MARK: - Codable Helpers
    
    func object<T: Codable>(for key: DefaultsKey) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        return (try? JSONDecoder().decode(T.self, from: data)) ?? nil
    }
    
    func objects<T: Codable>(for key: DefaultsKey) -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return [] }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }
    func set<T: Codable>(_ value: T, for key: DefaultsKey) {
        guard let data = (try? JSONEncoder().encode(value)) else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
}
