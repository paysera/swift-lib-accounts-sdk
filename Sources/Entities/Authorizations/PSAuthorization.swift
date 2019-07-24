import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSAuthorization: Mappable {
    
    public var id: String!
    public var accountNumber: String!
    public var users: [PSAuthorizationUser]!
    public var readPermission = false
    public var writePermission = false
    public var signPermission: PSSignPermission?
    public var validFrom: Date?
    public var validTo: Date?
    public var replacedAuthorizationId: String?
    
    public init(){ }
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id                         <- map["id"]
        accountNumber              <- map["account_number"]
        users                      <- map["users"]
        readPermission             <- map["read_permission"]
        writePermission            <- map["write_permission"]
        signPermission             <- map["sign_permission"]
        validFrom                  <- (map["valid_from"], DateTransform())
        validTo                    <- (map["valid_to"], DateTransform())
        replacedAuthorizationId    <- map["replaced_authorization_id"]
    }
}
