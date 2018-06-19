import ObjectMapper

public class PSPaymentCardLimit: Mappable {
    public var amount: PSMoney?
    public var period: Int?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount"]
        period    <- map["period"]
    }
}
