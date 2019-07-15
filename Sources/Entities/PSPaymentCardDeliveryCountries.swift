import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSPaymentCardDeliveryCountries: Mappable {
    public var items: [String]
    public var metaData: PSMetadata
    
    required public init?(map: Map) {
        do {
            items = try map.value("items")
            metaData = try map.value("_metadata")
        } catch {
            return nil
        }
    }
    
    public func mapping(map: Map) {
    }
}
