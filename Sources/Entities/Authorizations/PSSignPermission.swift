import PayseraCommonSDK
import ObjectMapper

public class PSSignPermission: Mappable {
    
    public var level: String?
    public var dayLimit: PSMoney?
    public var monthLimit: PSMoney?
    public var yearLimit: PSMoney?
    public var forAutomaticTransfers = false
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        level                   <- map["level"]
        dayLimit                <- map["day_limit"]
        monthLimit              <- map["month_limit"]
        yearLimit               <- map["year_limit"]
        forAutomaticTransfers   <- map["for_automatic_transfers"]
    }
    
}
