import ObjectMapper

public class PSPurposeCodeCollection: Mappable {

    public var items: [String] = []
    
    public init() { }
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        items <- map["purpose_codes"]
    }
}
