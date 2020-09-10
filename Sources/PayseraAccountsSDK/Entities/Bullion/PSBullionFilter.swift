import PayseraCommonSDK
import ObjectMapper

public class PSBullionFilter: PSBaseFilter {
    public var accountNumber: String!

    public override func mapping(map: Map) {
        super.mapping(map: map)
        accountNumber   <- map["account_number"]
    }
}
