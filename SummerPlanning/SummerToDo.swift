//
//  SummerToDo.swift
//  SummerPlanning
//
//  Created by Riya Kodali on 4/26/23.
//

import Foundation
import FirebaseFirestoreSwift

enum Month: String, CaseIterable, Codable {
    case May, June, July, August
}

enum PlanType: String, CaseIterable, Codable {
    case Vacation, Job, Event, Restaurant, ToDo, School, Other
}

struct SummerToDo: Identifiable, Codable {
    @DocumentID var id: String?
    var item = ""
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    var isCompleted = false
    var month = Month.May.rawValue
    var planType = PlanType.Other.rawValue

    var dictionary: [String: Any] {
        return ["item": item, "dueDate": dueDate, "notes": notes, "month": month, "planType": planType]
        }
    

}
