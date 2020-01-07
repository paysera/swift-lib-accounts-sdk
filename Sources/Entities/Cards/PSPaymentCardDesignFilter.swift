import PayseraCommonSDK
import ObjectMapper

public class PSPaymentCardDesignFilter: PSBaseFilter {
    public var accountOwnerId: Int?
    public var clientType: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        accountOwnerId <- map["account_owner_id"]
        clientType     <- map["client_type"]
    }
}
