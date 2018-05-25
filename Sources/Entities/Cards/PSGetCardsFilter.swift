import ObjectMapper

public class PSGetCardsFilter: Mappable {
    
    public var limit: Int?
    public var offset: Int?
    public var orderBy: String?
    public var orderDirection: String?
    public var accountNumbers: [String]?
    public var statuses: [String]?
    public var cardOwnerId: String?
    public var accountOwnerId: String?
    
    required public init?(map: Map) {
        
    }
    
    public init() {
    }
    
    public func mapping(map: Map) {
        limit           <- map["limit"]
        offset          <- map["offset"]
        orderBy         <- map["order_by"]
        orderDirection  <- map["order_direction"]
        accountNumbers  <- map["account_numbers"]
        statuses        <- map["statuses"]
        cardOwnerId     <- map["card_owner_id"]
        accountOwnerId  <- map["account_owner_d"]
    }
    
}
