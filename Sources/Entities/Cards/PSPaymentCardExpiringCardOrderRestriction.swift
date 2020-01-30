import Foundation
import ObjectMapper

public class PSPaymentCardExpiringCardOrderRestriction: Mappable {
    
    public var orderingAllowed: Bool!
    public var reason: String?
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        orderingAllowed <- map["ordering_allowed"]
        reason          <- map["reason"]
    }
}
