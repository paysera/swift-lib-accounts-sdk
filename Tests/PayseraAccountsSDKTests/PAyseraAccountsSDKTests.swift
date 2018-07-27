import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        let token = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDI4MTAwMDEyNDg2Mzc6bSIsImE6RVZQMTYxMDAwMTg0NTc0NDptIiwiYTpFVlA4NjEwMDAxNjcwMjM5Om0iLCJhOkVWUDkwMTAwMDE2NTAxMzY6bSJdLCJwc3I6dSI6NDUxNzQ1LCJleHAiOjE1Mjk0ODc1MDMsImlhdCI6MTUyOTQ4MzkwM30.6YjMPptRkMnpMXwCveM1zvp44hNPl5uflhnOGCh-QPNMIqKcuga--YuWkEuPFTaq_IbcrhBNOLOSaFvBUrRYoU1_b9xj_fLEvilLOa8bWsLyXfxQkxJK03FJfUPsSvfpZ878BCRhg1Si0BoVUnhz7khMEpPYuY6tzDvt9A_T9Xh6yWUSjcCsT9AfMR7yQCT-v72NpSkkYqQ_kCpyLXMG2RggfhHkQS7ZoEH8LhOh4d8AYXonCupsWp11yS0h_tFlNICnbOQpZufXx33pNmS2Ixm1xJ77PpCRX0wxP5be_h9IgIKAxjT73fLn_E8Q1JzPvYlx-cS2dajSigX3fFV7_3uJYM4Vp5WBKkvuhtRNqejhu734g8bJPSi72paK3EFnSxtfRlOtGK6_RjER6lM_LnHZCDmU-8jDzDe4Z0TTcJ1Ew7E01mdeZKsAnI82C7sG_QMC_dpgwJh3Xl-V_ZlyEIqWG-PDD3OsH07-BRgkyQikZd4ULmDU--qqmaxpwtGc_CIiHhfYJYLp2eYGf7m0swurCm4FE5tNGfcgoxufSuNU0J3yjoOa2P7Q4iqZb9GbKxx688mAUuLCY21XxzSCj4c5pbadt1-9A-HI5c499h5HZ2YZVJWV_jKfpheo4tsmav7Zq1UW1uSaBKjZm7djvCI-vUL_ZuojNMax_INyWjk"
        
        credentials.token = try! decode(jwt: token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetIbanInformation() {
        
        var ibanInformation: PSIbanInformation?
        let expectation = XCTestExpectation(description: "iban information should be not nil")
        
        let aa = PSCreatePaymentCardRequest(map: Map(mappingType: .toJSON, JSON: [:]))

        
        accountsApiClient.getIbanInformation(iban: "LT383500010001845744").done { ibanInfo in
            ibanInformation = ibanInfo
            print("\n")
            print(ibanInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print(error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(ibanInformation)
    }
    
    func testCreatePaymentCard() {
        
        var expectedCard: PSPaymentCard?
    
        let createPaymentCard = PSCreatePaymentCardRequest(cardOwnerId: 1001,
                                                    shippingAddress: PSPaymentCardShippingAddress.init(postalCode: "9999999999", address: "test", city: "Kaunas", country: "Lithuania"),
                                                    deliveryType: "registered_post", accountOwnerId: 1001,
                                                    chargeInfo: PSChargeInfo.init(accountNumber: "EVP1610001845744"))

        let expectation = XCTestExpectation(description: "cards should be not nil")

        accountsApiClient.createPaymentCard(createPaymentCard).done { createCardResponse in

            print("\n")
            print(createCardResponse.toJSON())
            expectedCard = createCardResponse
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }

        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(expectedCard)
    }
    
    func testGetCards() {
        
        let cardsFilter = PSGetPaymentCardsFilterRequest(accountOwnerId: "451745")
        var expectedCards: [PSPaymentCard]?
        
        let expectation = XCTestExpectation(description: "cards should be not nil")
        
        accountsApiClient.getPaymentCards(cardsFilter: cardsFilter).done { getCardsResponse in
            
            print("\n")
            print(getCardsResponse.toJSON())
            expectedCards = getCardsResponse.items
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(expectedCards)
    }
    
    func testGetBalanceInformation() {
        
        var balanceInformation: PSBalanceInformation?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.getBalance(accountNumber: "EVP1610001845744").done { balanceInfo in
            balanceInformation = balanceInfo
            
            print("\n")
            print(balanceInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(balanceInformation)
    }
}
