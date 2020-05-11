import PayseraCommonSDK
import ObjectMapper

public class PSConversionTransferFilter: PSBaseFilter {
    public var statuses: [String] = []
    public var accountNumbers: [String] = []
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        statuses            <- map["statuses"]
        accountNumbers      <- map["account_number_list"]
    }
}
