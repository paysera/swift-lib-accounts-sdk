import ObjectMapper

/// The entity class to get payment cards
public class PSGetPaymentCardsFilterRequest: Mappable {
    
    public private(set) var accountNumbers: [String]?
    public private(set) var cardOwnerId: String?
    public private(set) var accountOwnerId: String?
    public private(set) var limit: Int?
    public private(set) var offset: Int?
    public private(set) var orderBy: String?
    public private(set) var orderDirection: String?
    public private(set) var statuses: [String]?
    
    required public init?(map: Map) {
        
    }
    
    /// init PSGetPaymentCardsFilterRequest. One of accountNumbers, cardOwnerId or accountOwnerId must be filled
    ///
    /// - Parameters:
    ///   - accountNumbers: array of user payment cards numbers - optional
    ///   - cardOwnerId: optional
    ///   - accountOwnerId: optional
    ///   - limit: optional
    ///   - offset: optional
    ///   - orderBy: optional
    ///   - orderDirection: optional
    ///   - statuses: optional
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
