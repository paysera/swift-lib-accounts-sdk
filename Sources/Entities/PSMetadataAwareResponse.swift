import ObjectMapper

public class PSMetadataAwareResponse<T: Mappable>: Mappable  {
 
    public var items: [T]?
    public var metaData: PSMetaData?
    
    private var itemsResponseKey: String {
        
        switch T.self {
        case ( _) where T.self == PSPaymentCard.self:
            return "cards"

        default:
            return ""
        }
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        items       <- map[itemsResponseKey]
        metaData    <- map["_metadata"]
    }
}
