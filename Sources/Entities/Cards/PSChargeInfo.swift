import ObjectMapper


public class PSChargeInfo: Mappable {
    public var accountNumber: String
    
    public func mapping(map: Map) {
        accountNumber      <- map["account_number"]
    }
    
    required public init?(map: Map) {
        do {
            accountNumber = try map.value("account_number")
            
        } catch {
            print(error)
            return nil
        }
    }
}
