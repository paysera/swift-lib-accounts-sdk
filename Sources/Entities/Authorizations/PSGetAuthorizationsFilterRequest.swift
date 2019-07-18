import ObjectMapper

public class PSGetAuthorizationsFilterRequest: Mappable {
    
    public var accountNumbers: [String]!
    public var validFrom: Date?
    public var validTo: Date?
    public var limit: Int?
    public var offset: Int?
    public var orderBy: String?
    public var orderDirection: String?
    public var replacedAuthorizationIds: [Int]?
    
    required public init?(map: Map) {
        
    }
    
    public init(
        accountNumbers: [String],
        validFrom: Date? = nil,
        validTo: Date? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        orderBy: String? = nil,
        orderDirection: String? = nil,
        replacedAuthorizationIds: [Int]? = nil
        ) {
        self.accountNumbers = accountNumbers
        self.validFrom = validFrom
        self.validTo = validTo
        self.limit = limit
        self.offset = offset
        self.orderBy = orderBy
        self.orderDirection = orderDirection
        self.replacedAuthorizationIds = replacedAuthorizationIds
    }
    
    public func mapping(map: Map) {
        limit                           <- map["limit"]
        offset                          <- map["offset"]
        orderBy                         <- map["order_by"]
        orderDirection                  <- map["order_direction"]
        accountNumbers                  <- map["account_numbers"]
        replacedAuthorizationIds        <- map["replaced_authorization_ids"]
        validFrom                       <- (map["valid_from"], DateTransform())
        validTo                         <- (map["valid_to"], DateTransform())
    }
}
