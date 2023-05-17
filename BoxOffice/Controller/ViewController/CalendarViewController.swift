//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/17.
//

import UIKit

final class CalendarViewController: UIViewController {

    private lazy var calendarView = UICalendarView(frame: view.bounds)
    var changedDate: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(calendarView)
        configureCalendarView()
    }
    
    private func configureCalendarView() {

        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.fontDesign = .rounded
        calendarView.visibleDateComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: Date())

        calendarView.availableDateRange = DateInterval(start: Date.distantPast, end: Date.yesterday)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {

        guard let selectedDateComponent = dateComponents,
              let selectedDate = Calendar.current.date(from: selectedDateComponent) else { return }

        changedDate?(selectedDate)

        self.dismiss(animated: true)
    }
}
