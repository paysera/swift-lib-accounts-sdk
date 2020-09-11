import Foundation
import ObjectMapper

public class PSBankParticipationInformation: Mappable {
    public var sepaParticipant = false
    public var sepaInstantParticipant = false
    public var target2Participant = false

    required public init?(map: Map) { }

    public func mapping(map: Map) {
        sepaParticipant <- map["sepa_participant"]
        sepaInstantParticipant <- map["sepa_instant_participant"]
        target2Participant <- map["target2_participant"]
    }
}
