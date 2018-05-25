import Foundation
import ObjectMapper

public class PSMoney: Mappable {
    public var amount: String!
    public var currency: String!
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount"]
        currency  <- map["currency"]
    }    
}
