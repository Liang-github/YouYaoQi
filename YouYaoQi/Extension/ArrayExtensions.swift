//
//  ArrayExtensions.swift
//  YouYaoQi
//
//  Created by PengLiang on 2017/12/18.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

import Foundation


public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}
extension Array {
    public func get(at range: ClosedRange<Int>) -> Array {
        let halfOpenClampedRange = Range(range).clamped(to: Range(indices))
        return Array(self[halfOpenClampedRange])
    }
    
    public func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType}
    }
    
    public func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1..<count]) : nil
    }
    
    public func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        enumerated().forEach(body)
    }
    
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    public mutating func insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    public func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    public func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else {
            return nil }
        return Swift.max(count - 1 - index, 0)
    }
    
    public mutating func shuffle() {
        guard count > 1 else { return }
        var j: Int
        for i in 0..<(count - 2) {
            j = Int(arc4random_uniform(UInt32(count - i)))
            if i != i+j { self.swapAt(i, i+j)}
        }
    }
    
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
    
    public func takeMax(_ n: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(n, count))])
    }
    
    public func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return !contains { !body($0)}
    }
    
    public func testAll(is condition: Bool) -> Bool {
        return testAll { ( ($0 as? Bool) ?? !condition == condition) }
    }
}

extension Array where Element: Equatable {
    public func contains(_ array: [Element]) -> Bool {
        return array.testAll{(self.index(of: $0) ?? -1 >= 0)}
    }
    
    public func contains(_ elements: Element...) -> Bool {
        return elements.testAll { self.index(of: $0) ?? -1 >= 0 }
    }
    
    public func indexes(of element: Element) -> [Int] {
        return enumerated().flatMap { ($0.element == element) ? $0.offset : nil}
    }
    
    public func laseIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }
    
    public mutating func removeFirst(_ element: Element) {
        guard let index = index(of: element) else { return }
        self.remove(at: index)
    }
    
    public mutating func removeAll(_ firstElement: Element?, _ elements: Element...) {
        var removeAllArr = [Element]()
        
        if let firstElementVal = firstElement {
            removeAllArr.append(firstElementVal)
        }
        
        elements.forEach({element in removeAllArr.append(element)})
        
        removeAll(removeAllArr)
    }
    
    public mutating func removeAll(_ elements: [Element]) {
        self = filter { !elements.contains($0)}
    }
    
    public func differeence(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                if value.contains(element) {
                    continue elements
                }
            }
            result.append(element)
        }
        return result
    }
    
    public func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()
        
        for (i, value) in values.enumerated() {
            if i > 0 {
                result = intersection
                intersection = Array()
            }
            
            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }
    public func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return self
    }
    
    public func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1]}
    }
}
