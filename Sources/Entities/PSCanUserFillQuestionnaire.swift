import Foundation
import ObjectMapper

public class PSCanUserFillQuestionnaire: Mappable {
    
    public var allowed: Bool
    
    required public init?(map: Map) {
        do {
            allowed = try map.value("allowed")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}

