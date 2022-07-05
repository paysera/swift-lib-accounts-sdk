import ObjectMapper

//"configuration": {
//    "is_initial": false,
//    "feature_flags": [
//        "natural_questionnaire_activities_information",
//        "questionnaire_fund_change",
//        "natural_questionnaire_services",
//        "questionnaire_multiple_citizenship"
//    ],
//    "areas_of_activity": [
//        {
//            "id": "1",
//            "name": "questionnaire.activities.agriculture"
//        },
//        {
//            "id": "2",
//            "name": "questionnaire.activities.mining"
//        }
//        ...
//    ]
//}

public final class PSQuestionnaireAreasOfActivity {
    public var id: String
    public var name: String
    
    required public init?(map: Map) {
        do {
            id = try map.value("id")
            name  = try map.value("name")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}

public final class PSQuestionnaireConfiguration: Mappable {
    
    public var id: Int!
    public var isInitial: Int
    public var featureFlags: [String]
    public var areasOfActivity: [PSQuestionnaireAreasOfActivity]
    
    required public init?(map: Map) {
        
        print(map)
        
        do {
            isInitial = try map.value("is_initial")
            featureFlags  = try map.value("feature_flags")
            areasOfActivity = try map.value("areas_of_activity")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
