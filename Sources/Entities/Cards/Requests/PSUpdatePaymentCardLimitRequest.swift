import ObjectMapper

public class PSUpdatePaymentCardLimitRequest: Mappable {
    public var amount: String?
    public var currency: String?
    public var period: Int?
    
    required public init?(map: Map) {
    }
    
    public init() {
    }
    
    public init(amount: String, currency: String, period: Int = 3600) {
        self.amount = amount
        self.currency = currency
        self.period = period
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount.amount"]
        currency  <- map["amount.currency"]
    }
}
