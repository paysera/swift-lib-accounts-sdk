import PayseraCommonSDK
import ObjectMapper

public class PSAuthorizationUserLimit: Mappable {
    public var day: PSMoney?
    public var month: PSMoney?
    public var year: PSMoney?
    
    public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        day          <- map["day_limit"]
        month        <- map["month_limit"]
        year         <- map["year_limit"]
    }
}
