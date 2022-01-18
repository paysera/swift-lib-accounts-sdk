import ObjectMapper

public class PSAdditionalTransferInformationNeeded: Mappable {
    public var value: Bool!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        value  <- map["additional_info_needed"]
    }
}
