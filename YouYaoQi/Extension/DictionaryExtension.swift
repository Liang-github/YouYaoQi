//
//  DictionaryExtension.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/18.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import Foundation


extension Dictionary {
    public func random() -> Value? {
        return Array(values).random()
    }
    
    public func union(_ dictionaries: Dictionary...) -> Dictionary {
        var result = self
        dictionaries.forEach { (dictionary) -> Void in
            dictionary.forEach { (arg) -> Void in
                let (key, value) = arg
                result[key] = value
            }
        }
        return result
    }
    
    public func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    public func toArray<V>(_ map: (Key, Value) -> V) -> [V] {
        return self.map(map)
    }
    
    public func mapValues<V>(_ map: (Key, Value) -> V) -> [Key: V] {
        var mapped: [Key: V] = [:]
        forEach {
            mapped[$0] = map($0, $1)
        }
        return mapped
    }
    
    public func mapFilterValues<V>(_ map: (Key, Value) -> V?) -> [Key: V] {
        var mapped: [Key: V] = [:]
        forEach {
            if let value = map($0, $1) {
                mapped[$0] = value
            }
        }
        return mapped
    }
    
    public func mapFilter<K, V>(_ map: (Key, Value) -> (K, V)?) -> [K: V] {
        var mapped: [K: V] = [:]
        forEach {
            if let value = map($0, $1) {
                mapped[value.0] = value.1
            }
        }
        return mapped
    }
    
    public func map<K, V>(_ map: (Key, Value) -> (K, V)) -> [K: V] {
        var mapped: [K: V] = [:]
        forEach {
            let (_key, _value) = map($0, $1)
            mapped[_key] = _value
        }
        return mapped
    }
    
    public func filter(_ test: (Key, Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        for (key, value) in self {
            if test(key, value) {
                result[key] = value
            }
        }
        return result
    }
    
    public func testAll(_ test: (Key, Value) -> Bool) -> Bool {
        return !contains { !test($0, $1)}
    }
    
    public static func constructFromJSON(json: String) -> Dictionary? {
        if let data = (try? JSONSerialization.jsonObject(with: json.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary {
            return data
        } else {
            return nil
        }
    }
    
    public func formatJSON() -> String? {
        if let jsonData = try?JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
}
extension Dictionary where Value: Equatable {
    public func difference(_ dictionaries: [Key: Value]...) -> [Key: Value] {
        var result = self
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.has(key) && result[key] == value {
                    result.removeValue(forKey: key)
                }
            }
        }
        return result
    }
}
public func += <KeyType, ValueType> (left: inout
    [KeyType: ValueType], right: [KeyType: ValueType]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
