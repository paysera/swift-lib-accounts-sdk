import ObjectMapper
import PayseraCommonSDK

public class PSBalanceInformation: Mappable {
    
    public var accountNumber: String!
    public var balance: [PSBalance]?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        accountNumber  <- map["account_number"]
        balance        <- map["balance"]
    }
}

public class PSBalance: Mappable {
    public var currency: String!
    public var atDisposal: PSMoney!
    public var reserved: PSMoney!
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        currency    <- map["currency"]
        atDisposal  <- map["at_disposal"]
        reserved    <- map["reserved"]

    }
}

