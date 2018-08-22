import ObjectMapper

public class PSUpdatePaymentCardLimirRequest: Mappable {
    public var amount: Float?
    public var currency: String?
    public var period: Int?
    
    required public init?(map: Map) {
    }
    
    public init(amount: Float, currency: String, period: Int = 3600) {
        self.amount = amount
        self.currency = currency
        self.period = period
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount.amount"]
        currency  <- map["amount.currency"]
    }
}
