//
//  ViewController.swift
//  NativeCalendarTest
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import UIKit

import NativeCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var calendarView: CalendarView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        let currentDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let startDate = calendar.date(
            byAdding: .month,
            value: -3,
            to: currentDate) ?? currentDate
        
        let endDate = calendar.date(
            byAdding: .month,
            value: 3,
            to: currentDate) ?? currentDate
        
        let offDays = ["03/02/2024","22/03/2024","15/04/2024", "05/04/2024"]
        let offDates = Helpers.shared.getDate(dateString: offDays)
        
        let daysWithEvents = ["04/02/2024","23/03/2024","16/04/2024", "06/04/2024"]
        let datesWithEvents = Helpers.shared.getDate(dateString: daysWithEvents)
        let calendarData = getCalendarData(datesWithEvents: datesWithEvents)
        
        calendarView.setCellStyle(defaultLabelColor: .label, selectedLabelColor: .white, offDaysColor: .secondaryLabel, selectedBGColor: [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor])
        
        calendarView.setData(calendar: calendar,
                             cellType: .CalendarDayCellType,
                             offDates: offDates,
                             datesWithEvents: calendarData,
                             endDate: endDate,
                             startDate: startDate,
                             firstWeekDay: .saturday,
                             selectionType: .from_to) { userSelection in
            userSelection.forEach { selection in
                selection.events?.forEach({ event in
                    (event as! InterView).printDetails(date: selection.dateUTC)
                })
            }
        }
        
    }
    
    var dateEvent = InterView(title: "Interview", location: "Office", name: "Ali", interviewer: "Sami")

    func getCalendarData(datesWithEvents: [Date]) -> [CalendarData<Codable>] {
        return datesWithEvents.map { date in
            CalendarData(date: date, events: Array.init(repeating: dateEvent, count: Int.random(in: 1...2)))
        }
    }
    
}

struct InterView: Codable {
    var title, location, name, interviewer: String
    
    func printDetails(date: TimeInterval) {
        print("Date: \(date) \nTitle: \(title) \nLocation: \(location) \nName: \(name) \nInterviewer: \(interviewer) \n")
    }
}
