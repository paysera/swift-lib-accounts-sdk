import ObjectMapper
import PayseraCommonSDK

public class PSTransfersResult: Mappable {
    public var metadata: PSMetadata?
    public var transfersResult: [PSTransfer]?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        metadata         <- map["_metadata"]
        transfersResult  <- map["transfers"]
    }
}
