import Foundation
import ObjectMapper

public class PSInformationRequest: Mappable {
    
    public var id: String!
    public var transferId: String!
    public var transferInformation: PSTransferInformation!
    public var comment: String?
    public var status: String?
    public var createdAt: TimeInterval?
    public var answeredAt: TimeInterval?
    public var questions: [PSInformationRequestQuestion]!
    public var requestedFrom: String!
    public var files: [PSInformationRequestFile]?
    public var requestedDocuments: PSInformationRequestRequestedDocuments!
    
    public init() {}
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        id                    <- map["id"]
        transferId            <- map["transfer_id"]
        transferInformation   <- map["transfer_information"]
        comment               <- map["comment"]
        status                <- map["status"]
        createdAt             <- map["created_at"]
        answeredAt            <- map["answered_at"]
        questions             <- map["questions"]
        requestedFrom         <- map["requested_from"]
        files                 <- map["files"]
        requestedDocuments    <- map["requested_documents"]
    }
}
