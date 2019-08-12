import Foundation
import PayseraCommonSDK
import ObjectMapper

public class PSTransferFilter: PSBaseFilter {
    public var status: [String] = []
    public var creditAccountNumber: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        status              <- map["status"]
        creditAccountNumber <- map["credit_account_number"]
    }
}
