import PayseraCommonSDK
import ObjectMapper

public class PSAvailableCurrencyFilter: PSBaseFilter {
    public var userId: Int!
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["account_owner_user_id"]
    }
}
