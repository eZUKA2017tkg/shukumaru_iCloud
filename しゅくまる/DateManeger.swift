//
//  DateManeger.swift
//  しゅくまる
//
//  Created by miyu.s on 2017/11/06.
//  Copyright © 2017年 miyu.s. All rights reserved.
//

import UIKit

extension Date {
    func monthAgoDate() -> Date {
        let addValue = -1 //一つ前の月を表示
        let calender = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calender.date(byAdding: dateComponents, to: self)!
    }
    
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        let calender = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calender.date(byAdding: dateComponents, to: self)!
    }
}


class DateManeger: NSObject {

    var currentMonthDates = [NSDate]() //表記する月の配列
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int! = 0
    
    //月ごとのセルの数を返すメソッド
    func daysAcquisition() -> Int {
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date)
        let numberOfWeeks = Int((rangeOfWeeks?.count)!) //月がもつ週の数
        numberOfItems = numberOfWeeks * daysPerWeek //週の数 * 列の数
        return numberOfItems
    }
    
    //月の初日を取得
    func firstDateOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate as Date)
        components.day = 1
        let firstDateMonth = Calendar.current.date(from: components)!
        return firstDateMonth
    }
    
    //表記する日にちの取得
    func dateForCellAtIndexPath(numberOfItem: Int) {
        
        //月の初日が週の何日めかを計算する
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth())
        
        for i in 0..<numberOfItem {
            //「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            //表示する月の初日から計算した差を引いた日付を取得
            let date = Calendar.current.date(byAdding: dateComponents as DateComponents, to: firstDateOfMonth() as Date)!
            //配列に追加
            currentMonthDates.append(date as NSDate)
        }
    }
    
    //表記の変更
    func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItem: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthDates[indexPath.row] as Date)
    }
    
    //前月の表示
    func prevMonth(date:Date) -> Date {
        currentMonthDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    //次月の表示
    func nextMonth(date: Date) -> Date {
        currentMonthDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }

}
