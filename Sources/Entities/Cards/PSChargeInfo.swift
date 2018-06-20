import ObjectMapper

/// The entity class specifying from which account charge a commissions
public class PSChargeInfo: Mappable {
    public var accountNumber: String
    
    required public init?(map: Map) {
        do {
            accountNumber = try map.value("account_number")
            
        } catch {
            print(error)
            return nil
        }
    }
    
    public init(accountNumber: String) {
        self.accountNumber = accountNumber
    }
    
    public func mapping(map: Map) {
        accountNumber      <- map["account_number"]
    }
}
