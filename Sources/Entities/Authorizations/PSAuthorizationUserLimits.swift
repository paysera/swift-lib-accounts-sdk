import PayseraCommonSDK
import ObjectMapper

public class PSAuthorizationUserLimits: Mappable {
    
    public var defaultSigningLimitDay: PSMoney?
    public var defaultSigningLimitMonth: PSMoney?
    public var defaultSigningLimitYear: PSMoney?
    
    public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        defaultSigningLimitDay          <- map["default_signing_limits.day_limit"]
        defaultSigningLimitMonth        <- map["default_signing_limits.month_limit"]
        defaultSigningLimitYear         <- map["default_signing_limits.year_limit"]
    }
}

