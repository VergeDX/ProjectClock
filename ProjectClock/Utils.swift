//
//  Utils.swift
//  ProjectClock
//
//  Created by Hykilpikonna on 1/17/21.
//

import Foundation

extension Date
{
    /// Add toString to Date
    func str() -> String
    {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return f.string(from: self)
    }
    
    /// Constructor from components
    static func create(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int) -> Date
    {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day
        c.hour = hour
        c.minute = minute
        let cal = Calendar(identifier: .gregorian)
        return cal.date(from: c)!
    }
    
    /// Get year, month, day
    func getYMD() -> (y: Int, m: Int, d: Int)
    {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return (comp.year!, comp.month!, comp.day!)
    }
    
    /// Get hour, minute, seconds
    func getHMS() -> (h: Int, m: Int, s: Int)
    {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute, .second], from: self)
        return (comp.hour!, comp.minute!, comp.second!)
    }
    
    /// Get another component
    func get(_ c: Calendar.Component) -> Int
    {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([c], from: self)
        return comp.value(for: c)!
    }
    
    /// Return a new modified date
    func added(_ c: Calendar.Component, _ v: Int) -> Date
    {
        return Calendar.current.date(byAdding: c, value: v, to: self)!
    }
}

extension TimeInterval
{
    var seconds: Int { return Int(self) % 60 }
    var minutes: Int { return (Int(self) / 60) % 60 }
    var hours: Int { return (Int(self) / 3600) % 24 }
    var days: Int { return Int(self) / (3600 * 24) }
    
    /// Add toString to time interval
    func str() -> String
    {
        if days != 0 { return "\(days)d \(hours)h \(minutes)m \(seconds)s" }
        else if hours != 0 { return "\(hours)h \(minutes)m \(seconds)s" }
        else if minutes != 0 { return "\(minutes)m \(seconds)s" }
        else { return "\(seconds)s" }
    }
}

/// Apply like Kotlin
protocol HasApply {}
extension HasApply
{
    @discardableResult
    func apply(_ c: (Self) -> ()) -> Self
    {
        c(self)
        return self
    }
}
extension Alarm: HasApply {}
extension Alarms: HasApply {}
