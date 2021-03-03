import ObjectMapper

public class PSClientAllowance: Mappable {
    
    public var userId: Int!
    public var canOrderCard = false
    public var canFillQuestionnaire = false
    public var canCreateAccount = false
    public var accountAuthorizationAllowances: [PSAccountAuthorizationAllowance] = []
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        userId                          <- map["covenantee_id"]
        canOrderCard                    <- map["can_order_card"]
        canFillQuestionnaire            <- map["can_fill_questionnaire"]
        canCreateAccount                <- map["can_create_account"]
        accountAuthorizationAllowances  <- map["can_create_authorization"]
    }
}
