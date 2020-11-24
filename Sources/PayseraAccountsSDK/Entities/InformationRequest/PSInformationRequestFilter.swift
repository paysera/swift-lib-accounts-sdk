import ObjectMapper
import PayseraCommonSDK

public class PSInformationRequestFilter: PSBaseFilter {
    
    public var transferId: String?
    public var accountNumbers: [String]!
    public var status: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        transferId           <- map["transfer_id"]
        accountNumbers       <- map["account_numbers"]
        status               <- map["status"]
    }
}
