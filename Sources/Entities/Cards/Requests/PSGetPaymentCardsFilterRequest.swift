import ObjectMapper

public class PSGetPaymentCardsFilterRequest: Mappable {
    
    public var accountNumbers: [String]?
    public var cardOwnerId: String?
    public var accountOwnerId: String?
    public var limit: Int?
    public var offset: Int?
    public var orderBy: String?
    public var orderDirection: String?
    public var statuses: [String]?
    
    required public init?(map: Map) {
        
    }

    public init(accountNumbers: [String]? = nil,
                cardOwnerId: String? = nil,
                accountOwnerId: String? = nil,
                limit: Int? = nil,
                offset: Int? = nil,
                orderBy: String? = nil,
                orderDirection: String? = nil,
                statuses: [String]? = nil) {
        
        self.accountNumbers = accountNumbers
        self.cardOwnerId = cardOwnerId
        self.accountOwnerId = accountOwnerId
        self.limit = limit
        self.offset = offset
        self.orderBy = orderBy
        self.orderDirection = orderDirection
        self.statuses = statuses
    }
    
    public func mapping(map: Map) {
        limit           <- map["limit"]
        offset          <- map["offset"]
        orderBy         <- map["order_by"]
        orderDirection  <- map["order_direction"]
        accountNumbers  <- map["account_numbers"]
        statuses        <- map["statuses"]
        cardOwnerId     <- map["card_owner_id"]
        accountOwnerId  <- map["account_owner_id"]
    }
    
}
