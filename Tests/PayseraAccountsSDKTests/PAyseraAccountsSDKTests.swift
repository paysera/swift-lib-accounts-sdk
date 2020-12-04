import Foundation
import XCTest
import PayseraAccountsSDK
import PayseraCommonSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE2MDcwOTYwNzIsImp0aSI6IjFEdzdZU0FsVEktQTA0MUhVbGJCZzQ4TjN5aHBGdW9OIiwicHNyOnMiOlsiY29uZmlybWVkX2xvZ19pbiJdLCJwc3I6dSI6IjgxMzQyNTkiLCJwc3I6c2lkIjoiY0pOT2JUaTZ5VDFyTTBCLWU1bExqZVdtRlNZeVZuX3EiLCJwc3I6YSI6eyJ1c2VyX2lkIjoiODEzNDI1OSJ9LCJpYXQiOjE2MDcwNTI4NzJ9.rxyfZmsqJFICLm1NoJ2AEMyXI3u72U_ZfybG4W5ssmoILywV8-hnU-yHxCSvwnO0dugMgkHbchNtG4n_hOBrVenAbtiDSB2TvXwCDSj9goeBS1U9x0iIzHWUXPvDroEcP95Cks-zRDIvlHRhcMCRI2Z6IPlZLIkVBG1IAF4oBJIBRMZ4Anyj83hNPh0mHZ3-Pxj_f1jfP-PZyHnvAHa8X7fgX9ty7gSU7yXKsiE8ZBRfldwJtIF-Pp3wfTpe2mFzyTxE1KiJv-Pq7OoKFzjMPWUnaCPdoNOhiNtakjDQNoxoWmPCJx2UbH19ed6jpfuosCKskLHJGwNuEFSjyk_VgBAb_o6Y7M5hejTwBiyKv6xCqxJYd_cB4Xp37XS6FHTrofjLyr3PyC-JyULxW8NhrWANrdQXhS7NXh-zXXrJswX1daQATu6DblzaY9iYn_GSVJ_kJ509ATXqLCo0_NtKijKcDfbKKHb_gMXX_dZ8kQdBpHcieWUuuixEHNy0waih4qB-IYgsfXD6JJZwnDeXpU33RUtiqN2eZdvuMz19kZmTkhIaA7sjTcu72vejKDbJXbC0jl8Dxw4FnAdT8Gbn2-ZTk0ArZEEPvIrwvpVBaW1nWmnuOmiAtSVtPyqfFWMUW-AUCzPBjA7Oe31DgQWWAmXBR5aomzHH-sb5WCFVLUc"
        
        let credentials = PSApiJWTCredentials()
        credentials.token = try! decode(jwt: token)
        
        accountsApiClient = AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetPurposeCodes() {
        var actual: PSPurposeCodeCollection?
        let expectation = XCTestExpectation(description: "Purpose codes field must exist")
        
        accountsApiClient
            .getPurposeCodes()
            .done { actual = $0 }
            .catch { print($0) }
            .finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(actual)
    }
    
    func testGetAvailableCurrencies() {
       var object: PSMetadataAwareResponse<PSAvailableCurrency>?
       let expectation = XCTestExpectation(description: "")
       
       let filter = PSAvailableCurrencyFilter()
       filter.userId = 165660
       accountsApiClient
           .getAvailableCurrencies(filter: filter)
           .done { result in
               object = result
           }.catch { error in
               print(error)
           }.finally { expectation.fulfill() }
       
       wait(for: [expectation], timeout: 3.0)
       XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDesigns() {
        var object: PSMetadataAwareResponse<PSPaymentCardDesign>?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSPaymentCardDesignFilter()
        filter.accountOwnerId = 165660
        accountsApiClient
            .getPaymentCardDesigns(filter: filter)
            .done { designs in
                object = designs
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetIbanInformation() {
        var object: PSIbanInformation?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getIbanInformation(iban: "LT383500010001845744")
            .done { ibanInfo in
                object = ibanInfo
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetIbanInformationForTarget2Participant() {
        var object: PSIbanInformation?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getIbanInformation(iban: "TR220011100000000073417181")
            .done { ibanInfo in
                object = ibanInfo
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue((object?.target2Participant ?? false), "IbanInformation must be a target2Participant")
    }
    
    func testGetPaymentCardShippingAddress() {
        var object: PSPaymentCardShippingAddress?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardShippingAddress(accountNumber: "EVP3710004041407")
            .done { shippingAddress in
                object = shippingAddress
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testActivateCardForXPay() {
        var object: PSXpayToken?
        let expectation = XCTestExpectation(description: "")

        accountsApiClient
            .activateCardForXPay(id: 691641)
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }

    func testProvisionCardForXPay() {
        var object: PSXpayToken?
        let expectation = XCTestExpectation(description: "")

        let cardId = 691641
        let request = PSXpayTokenRequest(
            cardId: cardId,
            certificateLeaf: "test",
            certificateSubCA: "test",
            nonce: "test",
            nonceSignature: "test"
        )
        accountsApiClient
            .provisionCardForXPay(id: cardId, request: request)
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }

    func testGetPaymentCardDeliveryPrices() {
        var object: [PSPaymentCardDeliveryPrice]?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryPrices(country: "de")
            .done { deliveryPrices in
                object = deliveryPrices
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryDate() {
        var object: PSPaymentCardDeliveryDate?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryDate(country: "de", deliveryType: "regular")
            .done { deliveryDate in
                object = deliveryDate
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardIssuePrice() {
        var object: PSPaymentCardIssuePrice?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSPaymentCardIssuePriceFilter()
        filter.cardAccountOwnerId = "6720691"
        filter.cardOwnerId = "6720691"
        
        accountsApiClient
            .getPaymentCardIssuePrice(filter: filter)
            .done { issuePrice in
                object = issuePrice
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryCountries() {
        var object: PSPaymentCardDeliveryCountries?
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSBaseFilter()
        filter.limit = 200
        
        accountsApiClient
            .getPaymentCardDeliveryCountries(filter: filter)
            .done { response in
                object = response
                
                print(object ?? "N/A")
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCreateAccount() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id
        accountsApiClient.createAccount(userId: 111111).done { result in
            object = result
            }.catch { error in
                print(error)
        }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testSetAccountDescription() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert user id and account number
        accountsApiClient.setAccountDescription(userId: 111111,
                                                accountNumber: "change me",
                                                description: "modric").done { result in
                                                    object = result
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetAuthorizations() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        //insert accountNumbers
        let fitler = PSGetAuthorizationsFilterRequest(accountNumbers: [""])
        accountsApiClient.getAuthorizations(filter: fitler).done { result in
            object = result
            print(result.items ?? "N/A")
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCreateAuthorizations() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        let authorization = PSCreateAuthorizationRequest(accountNumber: "", userIds: [""])
        authorization.readPermission = true
        accountsApiClient.createAuthorization(authorization: authorization).done { result in
            object = result
            print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testDeleteAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        accountsApiClient.deleteAuthorization(id: "insert authorization id").done { result in
            object = result
            print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testUpdateAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
      
        let authorization = PSCreateAuthorizationRequest(accountNumber: "", userIds: [""])
        accountsApiClient
            .updateAuthorization(id: "insert authorization id", authorization: authorization)
            .done { result in
                object = result
                print(result)
            }.catch { error in
                print(error)
            }.finally {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardDeliveryPreference() {
        var object: PSPaymentCardDeliveryPreference?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardDeliveryPreference(accountNumber: "EVP9410007208697")
            .done { deliveryPreference in
                object = deliveryPreference
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetPaymentCardExpiringCardOrderRestriction() {
        var object: PSPaymentCardOrderRestriction?
        let expectation = XCTestExpectation(description: "")
        
        accountsApiClient
            .getPaymentCardExpiringCardOrderRestriction(accountNumber: "EVP3710004041407")
            .done { r in
                object = r
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testSetPaymentCardDeliveryPreference() {
        
        var object: Any?
        let expectation = XCTestExpectation(description: "")
        
        let preference = PSPaymentCardDeliveryPreference()
        preference.ownerId = 9007334
        preference.shippingAddress = PSPaymentCardShippingAddress(postalCode: "08426", address: "address", city: "Vilnius", country: "lt")
        preference.deliveryType = "regular"
        
        accountsApiClient
            .setPaymentCardDeliveryPreference(accountNumber: "EVP9410007208697",
                                              preference: preference
        )
            .done { result in
                object = result
        }.catch { error in
            print(error)
        }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testDeleteUserFromAuthorization() {
        let expectation = XCTestExpectation(description: "")
        var object: Any?
        accountsApiClient.deleteUserFromAuthorization(authorizationId: "insert_auth_id", userId: "0").done { result in
            object = result
        }.catch { error in
            print(error)
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetSigningLimits() {
        let expectation = XCTestExpectation(description: "Should return signing limits for a given user")
        var limits: PSAuthorizationUserLimits?
        
        accountsApiClient
            .getSigningLimits(userId: 0)
            .done { signingLimits in limits = signingLimits }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(limits)
    }
    
    func testValidatingAuthorizationUsers() {
        let expectation = XCTestExpectation(description: "Should validate if users can be added to an authorization")
        var validationResponse: PSMetadataAwareResponse<PSAuthorizationUserValidationResult>?
        
        accountsApiClient
            .validateAuthorizationUsers(userIds: [])
            .done { response in validationResponse = response }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(validationResponse)
    }
    
    func testGetConversionTransfers() {
        let expectation = XCTestExpectation(description: "")
        var object: [PSConversionTransfer]?
        let filter = PSConversionTransferFilter()
        filter.accountNumbers = [""]
        filter.statuses = ["prepared"]
        accountsApiClient
            .getConversionTransfers(filter: filter)
            .done { result in
                object = result.items
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testSignConversionTransfer() {
        let expectation = XCTestExpectation(description: "")
        var object: PSConversionTransfer?
        accountsApiClient
            .signConversionTransfer(transferId: "")
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testCancelConversionTransfer() {
        let expectation = XCTestExpectation(description: "")
        var object: PSConversionTransfer?
        accountsApiClient
            .cancelConversionTransfer(transferId: "")
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testGetCardOrderRestrictions() {
        let expectation = XCTestExpectation(description: "")
        var object: PSMetadataAwareResponse<PSPaymentCardOrderRestriction>?
        accountsApiClient
            .getCardOrderRestrictions(cardAccountOwnerId: 0, cardOwnerId: 0)
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testGetTransfer() {
        let expectation = XCTestExpectation(description: "")
        var object: PSTransfer?
        let transferId = "insert_me"
        
        accountsApiClient
            .getTransfer(id: transferId)
            .done { result in
                object = result
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testGetBankParticipationInfo() {
        let expectation = XCTestExpectation(description: "")
        let swift = "insert_me"
        var object: PSBankParticipationInformation?
        accountsApiClient
            .getBankParticipationInformation(swift: swift)
            .done { object = $0 }
            .catch { error in print(error) }
            .finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
    
    func testGetBullionItems() {
        let expectation = XCTestExpectation(description: "Bullion items that are owned by user should be returned")
        var object: PSMetadataAwareResponse<PSBullion>?
        let filter = PSBullionFilter()
        filter.accountNumber = "EVPXXXXXXXXXXXXXXX"

        accountsApiClient
            .getBullionItems(filter: filter)
            .done { result in object = result }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }

    func testGetBullionOptions() {
        let expectation = XCTestExpectation(description: "Available bullion options should be returned")
        var object: PSMetadataAwareResponse<PSBullionOption>?
        let filter = PSBaseFilter()

        accountsApiClient
            .getBullionOptions(filter: filter)
            .done { result in object = result }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }

    func testGetUnallocatedBullionBalance() {
        let expectation = XCTestExpectation(description: "Unallocated bullion balance should be returned")
        var object: PSMetadataAwareResponse<PSUnallocatedBullionBalance>?

        let filter = PSBullionFilter()
        filter.accountNumber = "EVPXXXXXXXXXXXXXXX"
        accountsApiClient
            .getUnallocatedBullionBalance(filter: filter)
            .done { result in object = result }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }

    func testBuyBullion() {
        let expectation = XCTestExpectation(description: "Bullion should be successfully bought")

        accountsApiClient
            .buyBullion(identifier: "test_coin", accountNumber: "EVPXXXXXXXXXXXXXXX")
            .done { }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSellBullion() {
        let expectation = XCTestExpectation(description: "Bullion should be successfully sold")

        accountsApiClient
            .sellBullion(hash: "jxqiXcgoQePkjk8FFahahaoxbwiZdUWl")
            .done { }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetSpreadPercentage() {
        var response: PSSpreadPercentageResponse?
        let expectation = XCTestExpectation(description: "Spread percentage should be returned")
        let request = PSSpreadPercentageRequest(
            accountNumber: "EVPXXXXXXXXXXXX",
            fromCurrency: "EUR",
            toCurrency: "XAU",
            toAmount: "0.04345"
        )

        accountsApiClient
            .getSpreadPercentage(request: request)
            .done { response = $0 }
            .catch { error in XCTFail(error.localizedDescription) }
            .finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(response)
    }
    
    func testGetInformationRequest() {
        var object: [PSInformationRequest]?
        let expectation = XCTestExpectation(description: "")
       
        let filter = PSInformationRequestFilter()
        filter.accountNumbers = ["0000"]
        filter.status = "waiting_for_answer"
        
        accountsApiClient
            .getInformationRequests(filter: filter)
            .done { response in
                object = response.items
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }
            .finally {
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testUploadInformationRequestFile() {
        var object: PSInformationRequestFile?
        let expectation = XCTestExpectation(description: "")
        
        let file = PSInformationRequestFile()
        file.hash = ""
        file.filename = ""
        
        accountsApiClient
            .uploadInformationRequestFile(id: "", file: file)
            .done { file in
                object = file
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }
            .finally {
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testUploadInformationRequestAnswers() {
        var object: PSInformationRequest?
        let expectation = XCTestExpectation(description: "")
      
        let answer1 = PSInformationRequestAnswer()
        answer1.questionId = ""
        answer1.answer = ""
        let answers = PSInformationRequestAnswers()
        answers.answers = [answer1]
        
        accountsApiClient
            .uploadInformationRequestAnswers(id: "", answers: answers)
            .done { request in
                object = request
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }
            .finally {
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetClientAllowances() {
        let expectation = XCTestExpectation(description: "")
        var object: [PSClientAllowance]?
        accountsApiClient
            .getClientAllowances()
            .done {
                object = $0
            }
            .catch {
                error in print(error)
            }
            .finally { expectation.fulfill() }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(object)
    }
}
