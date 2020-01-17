//
//  PopularsResDatabase.swift
//  Training
//
//  Created by ManhLD on 12/12/19.
//  Copyright © 2019 ManhLD. All rights reserved.
//


import Foundation
import RealmSwift
import SwiftyJSON

class MyPageWentResDatabase: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var photo = ""
    @objc dynamic var name = ""
    @objc dynamic var descriptionHtml = ""
    @objc dynamic var scheduleStartDate = ""
    @objc dynamic var scheduleEndDate = ""
    @objc dynamic var scheduleStartTime = ""
    @objc dynamic var scheduleEndTime = ""
    @objc dynamic var schedulePermanent = ""
    @objc dynamic var goingCount = 0
    
    convenience init(goingEvents : JSON) {
        self.init()
        self.id = goingEvents["id"].intValue
        self.photo = goingEvents["photo"].stringValue
        self.name = goingEvents["name"].stringValue
        self.descriptionHtml = goingEvents["description_html"].stringValue
        self.scheduleStartDate = goingEvents["schedule_start_date"].stringValue
        self.scheduleEndDate = goingEvents["schedule_end_date"].stringValue
        self.scheduleStartTime = goingEvents["schedule_end_date"].stringValue
        self.scheduleEndTime = goingEvents["schedule_end_time"].stringValue
        self.schedulePermanent = goingEvents["schedule_permanent"].stringValue
        self.goingCount = goingEvents["going_count"].intValue
    }
}


class MyPageWentListAPI: APIMeetUpService<MyPageWentData> {
    init(status: Int) {
        super.init(request: APIMeetUpRequest(name: "API008  Get events wents ", path: "listMyEvents", method: .get, header: APIMeetUpRequest.header, parameters: ["status" : "\(status)"]))
    }
}

struct MyPageWentData : MeetUpResponse {
    var listEventsWent = [MyPageWentResDatabase]()
    var status : Int!
    var errMessage : String!
    init(json: JSON) {
        status = json["status"].intValue
        if status == 0 {
            errMessage = json["error_message"].stringValue
        } else {
            let data = json["response"]["events"].array
            listEventsWent = data!.map({ (value) -> MyPageWentResDatabase in
                return MyPageWentResDatabase(goingEvents: value)
            })
        }
    }
}
