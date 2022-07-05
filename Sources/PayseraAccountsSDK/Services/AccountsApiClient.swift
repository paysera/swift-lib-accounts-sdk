import Foundation
import PayseraCommonSDK
import PromiseKit

public class AccountsApiClient: PSBaseApiClient {
    public func get(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        doRequest(requestRouter: AccountsApiRequestRouter.get(path: path, parameters: parameters))
    }
    
    public func post(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        doRequest(requestRouter: AccountsApiRequestRouter.post(path: path, parameters: parameters))
    }
    
    public func put(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        doRequest(requestRouter: AccountsApiRequestRouter.put(path: path, parameters: parameters))
    }
    
    public func put(path: String, data: Data, contentType: String) -> Promise<Any> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.putWithData(
                path: path,
                data: data,
                contentType: contentType
            )
        )
    }
    
    public func delete(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.delete(path: path, parameters: parameters)
        )
    }
    
    public func getTransfer(id: String) -> Promise<PSTransfer> {
        doRequest(requestRouter: AccountsApiRequestRouter.getTransfer(id: id))
    }

    public func setDefaultAccountDescription(
        accountNumber: String,
        description: String
    ) -> Promise<Void> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.setAccountDefaultDescription(
                accountNumber: accountNumber,
                description: description
            )
        )
    }
    
    public func setAccountDescription(
        userId: Int,
        accountNumber: String,
        description: String
    ) -> Promise<Void> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.setAccountDescription(
                userId: userId,
                accountNumber: accountNumber,
                description: description
            )
        )
    }

    public func activateAccount(accountNumber: String) -> Promise<PSAccount> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.activateAccount(accountNumber: accountNumber)
        )
    }
    
    public func deactivateAccount(accountNumber: String) -> Promise<PSAccount> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.deactivateAccount(accountNumber: accountNumber)
        )
    }
    
    public func getLastUserQuestionnaire(userId: Int) -> Promise<PSQuestionnaire> {
        doRequest(requestRouter: AccountsApiRequestRouter.getLastUserQuestionnaire(userId: userId))
    }
    
    public func getIbanInformation(
        iban: String,
        currency: String? = nil
    ) -> Promise<PSIbanInformation> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getIbanInformation(
                iban: iban,
                currency: currency
            )
        )
    }
    
    public func getBalance(
        accountNumber: String,
        showHistoricalCurrencies: Bool = false
    ) -> Promise<PSBalanceInformation> {
        doRequest(requestRouter: AccountsApiRequestRouter.getBalance(
            accountNumber: accountNumber,
            showHistoricalCurrencies: showHistoricalCurrencies
        ))
    }
    
    public func createAccount(userId: Int) -> Promise<PSAccount> {
        doRequest(requestRouter: AccountsApiRequestRouter.createAccount(userId: userId))
    }
    
    public func getAvailableCurrencies(filter: PSAvailableCurrencyFilter) -> Promise<PSMetadataAwareResponse<PSAvailableCurrency>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getAvailableCurrencies(filter: filter))
    }
    
    public func getConversionTransfers(filter: PSConversionTransferFilter) -> Promise<PSMetadataAwareResponse<PSConversionTransfer>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getConversionTransfers(filter: filter))
    }
    
    public func signConversionTransfer(transferId: String) -> Promise<PSConversionTransfer> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.signConversionTransfer(transferId: transferId)
        )
    }
    
    public func cancelConversionTransfer(transferId: String) -> Promise<PSConversionTransfer> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.cancelConversionTransfer(transferId: transferId)
        )
    }
    
    // MARK: - Payment cards API
    public func createPaymentCard(_ card: PSCreatePaymentCardRequest) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.createCard(card))
    }

    public func activateCard(id: Int, cvv: String) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.activateCard(id: id, cvv: cvv))
    }
    
    public func enableCard(_ id: Int) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.enableCard(id: id))
    }
    
    public func deactivatePaymentCard(id: Int) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.deactivateCard(id: id))
    }
    
    public func getCategorizedAccountNumbers(
        filter: PSGetCategorizedAccountNumbersFilterRequest
    ) -> Promise<PSMetadataAwareResponse<PSCategorizedAccountNumbers>> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getCategorizedAccountNumbers(filter: filter)
        )
    }
    
    public func retrievePaymentCardPIN(id: Int, cvv: String) -> Promise<PSPaymentCardPIN> {
        doRequest(requestRouter: AccountsApiRequestRouter.retrievePaymentCardPIN(id: id, cvv: cvv))
    }
    
    public func getPaymentCardDeliveryCountries(
        filter: PSBaseFilter
    ) -> Promise<PSPaymentCardDeliveryCountries> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryCountries(filter: filter)
        )
    }
        
    public func getPaymentCards(
        cardsFilter: PSGetPaymentCardsFilterRequest
    ) -> Promise<PSMetadataAwareResponse<PSPaymentCard>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCards(cardsFilter: cardsFilter))
    }
    
    public func setPaymentCardLimit(
        accountNumber: String,
        cardLimit: PSUpdatePaymentCardLimitRequest
    ) -> Promise<PSPaymentCardLimit> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.setPaymentCardLimit(
                accountNumber: accountNumber,
                cardLimit: cardLimit
            )
        )
    }
    
    public func getPaymentCardLimit(accountNumber: String) -> Promise<PSPaymentCardLimit> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardLimit(
                accountNumber: accountNumber
            )
        )
    }
    
    public func getPaymentCardDesigns(
        filter: PSPaymentCardDesignFilter
    ) -> Promise<PSMetadataAwareResponse<PSPaymentCardDesign>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDesigns(filter: filter))
    }
    
    public func getPaymentCardShippingAddress(
        accountNumber: String
    ) -> Promise<PSPaymentCardShippingAddress> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardShippingAddress(
                accountNumber: accountNumber
            )
        )
    }
    
    public func getPaymentCardDeliveryPrices(
        country: String
    ) -> Promise<[PSPaymentCardDeliveryPrice]> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryPrices(country: country)
        )
    }

    public func getPaymentCardIssuePrice(
        filter: PSPaymentCardIssuePriceFilter
    ) -> Promise<PSPaymentCardIssuePrice> {
        doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardIssuePrice(filter: filter))
    }
    
    public func getPaymentCardDeliveryDate(
        country: String,
        deliveryType: String
    ) -> Promise<PSPaymentCardDeliveryDate> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryDate(
                country: country,
                deliveryType: deliveryType
            )
        )
    }
    
    public func getPaymentCardExpiringCardOrderRestriction(
        accountNumber: String
    ) -> Promise<PSPaymentCardOrderRestriction> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardExpiringCardOrderRestriction(
                accountNumber: accountNumber
            )
        )
    }
    
    public func getClientAllowances() -> Promise<[PSClientAllowance]> {
        doRequest(requestRouter: AccountsApiRequestRouter.getClientAllowances)
    }
    
    public func cancelPaymentCard(id: Int) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.cancelPaymentCard(id: id))
    }
    
    public func activateCardForXPay(id: Int) -> Promise<PSXpayToken> {
        doRequest(requestRouter: AccountsApiRequestRouter.activateCardForXPay(id: id))
    }

    public func provisionCardForXPay(
        id: Int,
        request: PSXpayTokenRequest
    ) -> Promise<PSXpayToken> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.provisionCardForXPay(id: id, request: request)
        )
    }

    public func getPaymentCardDeliveryPreference(
        accountNumber: String
    ) -> Promise<PSPaymentCardDeliveryPreference> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryPreference(
                accountNumber: accountNumber
            )
        )
    }
    
    public func setPaymentCardDeliveryPreference(
        accountNumber: String,
        preference: PSPaymentCardDeliveryPreference
    ) -> Promise<PSPaymentCardDeliveryPreference> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.setPaymentCardDeliveryPreference(
                accountNumber: accountNumber,
                preference: preference
            )
        )
    }
    
    // MARK: - Authorizations API
    public func getAuthorizations(
        filter: PSGetAuthorizationsFilterRequest
    ) -> Promise<PSMetadataAwareResponse<PSAuthorization>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getAuthorizations(filter))
    }
    
    public func deleteAuthorization(id: String) -> Promise<Void> {
        doRequest(requestRouter: AccountsApiRequestRouter.deleteAuthorization(id: id))
    }
    
    public func createAuthorization(
        authorization: PSCreateAuthorizationRequest
    ) -> Promise<PSAuthorization> {
        doRequest(requestRouter: AccountsApiRequestRouter.createAuthorization(authorization))
    }
    
    public func updateAuthorization(
        id: String,
        authorization: PSCreateAuthorizationRequest
    ) -> Promise<PSAuthorization> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.updateAuthorization(
                id: id,
                createAuthorizationRequest: authorization
            )
        )
    }
    
    public func getPurposeCodes() -> Promise<PSPurposeCodeCollection> {
        doRequest(requestRouter: AccountsApiRequestRouter.getPurposeCodes)
    }
    
    public func deleteUserFromAuthorization(
        authorizationId: String,
        userId: String
    ) -> Promise<Void> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.deleteUserFromAuthorization(
                authorizationId: authorizationId,
                userId: userId
            )
        )
    }
    
    public func getSigningLimits(userId: Int) -> Promise<PSAuthorizationUserLimits> {
        doRequest(requestRouter: AccountsApiRequestRouter.getSigningLimits(userId: userId))
    }
    
    public func validateAuthorizationUsers(
        userIds: [Int]
    ) -> Promise<PSMetadataAwareResponse<PSAuthorizationUserValidationResult>> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.validateAuthorizationUsers(userIds: userIds)
        )
    }

    public func getCardOrderRestrictions(
        cardAccountOwnerId: Int,
        cardOwnerId: Int
    ) -> Promise<PSMetadataAwareResponse<PSPaymentCardOrderRestriction>> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getCardOrderRestrictions(
                cardAccountOwnerId: cardAccountOwnerId,
                cardOwnerId: cardOwnerId
            )
        )
    }
    
    public func getBankParticipationInformation(
        swift: String
    ) -> Promise<PSBankParticipationInformation> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getBankParticipationInfo(swift: swift)
        )
    }
    
    public func getBullionItems(
        filter: PSBullionFilter
    ) -> Promise<PSMetadataAwareResponse<PSBullion>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getBullionItems(filter: filter))
    }

    public func getBullionOptions(
        filter: PSBaseFilter
    ) -> Promise<PSMetadataAwareResponse<PSBullionOption>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getBullionOptions(filter: filter))
    }

    public func getUnallocatedBullionBalance(
        filter: PSBullionFilter
    ) -> Promise<PSMetadataAwareResponse<PSUnallocatedBullionBalance>> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.getUnallocatedBullionBalance(filter: filter)
        )
    }

    public func buyBullion(identifier: String, accountNumber: String) -> Promise<Void> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.buyBullion(
                identifier: identifier,
                accountNumber: accountNumber
            )
        )
    }

    public func sellBullion(hash: String) -> Promise<Void> {
        doRequest(requestRouter: AccountsApiRequestRouter.sellBullion(hash: hash))
    }

    public func getSpreadPercentage(
        request: PSSpreadPercentageRequest
    ) -> Promise<PSSpreadPercentageResponse> {
        doRequest(requestRouter: AccountsApiRequestRouter.getSpreadPercentage(request: request))
    }
    
    public func getInformationRequests(
        filter: PSInformationRequestFilter
    ) -> Promise<PSMetadataAwareResponse<PSInformationRequest>> {
        doRequest(requestRouter: AccountsApiRequestRouter.getInformationRequests(filter: filter))
    }
    
    public func uploadInformationRequestFile(
        id: String,
        file: PSFile
    ) -> Promise<PSInformationRequestUploadedFile> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.uploadInformationRequestFile(id: id, file: file)
        )
    }
    
    public func uploadInformationRequestAnswers(
        id: String,
        answers: PSInformationRequestAnswers
    ) -> Promise<PSInformationRequest> {
        doRequest(
            requestRouter: AccountsApiRequestRouter.uploadInformationRequestAnswers(
                id: id,
                answers: answers
            )
        )
    }
    
    public func unblockPaymentCardCVV(cardId: String) -> Promise<PSPaymentCard> {
        doRequest(requestRouter: AccountsApiRequestRouter.unblockPaymentCardCVV(cardId: cardId))
    }
    
    public func getIsAdditionalInformationNeeded(
        transferID: String
    ) -> Promise<PSAdditionalTransferInformationNeeded> {
        doRequest(
            requestRouter: AccountsApiRequestRouter
                .getIsAdditionalInformationNeeded(transferID: transferID)
        )
    }
    
    public func createTransferAmlDetailsDocument() -> Promise<PSTransferAmlDetailsDocument> {
        doRequest(requestRouter: AccountsApiRequestRouter.createTransferAmlDetailsDocument)
    }
    
    public func uploadTransferAmlDetailsDocumentFile(
        hash: String,
        file: PSFile
    ) -> Promise<PSTransferAmlDetailsDocument> {
        doRequest(
            requestRouter: AccountsApiRequestRouter
                .uploadTransferAmlDetailsDocumentFile(hash: hash, file: file)
        )
    }
    
    public func saveTransferAmlDetails(
        information: PSAdditionalTransferInformation
    ) -> Promise<PSAdditionalTransferInformation> {
        doRequest(
            requestRouter: AccountsApiRequestRouter
                .saveTransferAmlDetails(information: information)
        )
    }
    
    public func assignAdditionalTransferDetails(transferID: String, hash: String) -> Promise<PSAdditionalTransferInformation> {
        doRequest(
            requestRouter: AccountsApiRequestRouter
                .assignAdditionalTransferDetails(transferID: transferID, hash: hash)
        )
    }
    
    public func getPartner(userID: Int) -> Promise<PSMetadataAwareResponse<PSClientPartner>> {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let date = inputFormatter.string(from: Date())
        return doRequest(
            requestRouter: AccountsApiRequestRouter
                .getPartner(userID: userID, date: date)
        )
    }
    
    public func getQuestionnaireConfiguration(legalId: Int) -> Promise<[PSQuestionnaireConfiguration]> {
        let promise: Promise<[PSQuestionnaireConfiguration]> = doRequest(
            requestRouter: AccountsApiRequestRouter
                .getQuestionnaireConfiguration(legalId: legalId)
        )
        
        let updated = promise.map { configs -> [PSQuestionnaireConfiguration] in
            
            return configs.map { config in
                config.id = legalId
                
                return config
            }
        }
        
        return updated
    }
}
