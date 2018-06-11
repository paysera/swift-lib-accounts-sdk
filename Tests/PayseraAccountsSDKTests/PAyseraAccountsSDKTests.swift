import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        let token = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDI4MTAwMDEyNDg2Mzc6bSIsImE6RVZQMTYxMDAwMTg0NTc0NDptIiwiYTpFVlA4NjEwMDAxNjcwMjM5Om0iLCJhOkVWUDkwMTAwMDE2NTAxMzY6bSJdLCJwc3I6dSI6NDUxNzQ1LCJleHAiOjE1Mjg3MjIxOTQsImlhdCI6MTUyODcxODU5NH0.PnZxhVGDjKnjRTzqsMR_bolN7Vx3-j9b0zqC7eXT_Uo3T3zFEGWvbFtA2FaJC4FJjkmYFXlYqysTbxKLvA79uE_af2hUGbqD0kkEZ4lrWkaHM0aNfplUyg8jkuYFLO05soSfwBCkP5GSSEHnSybNHoOyKzjyedGBHRWRVTKnXkV7Q7NPwG-AP_CKbt0XxUjdwD_QiQCgF_bodhRhPPuNaw0cBAJjqs_myccWn0GL43FqvEK9SLAAwrPoOUAiep7HKcxmDXPo_LNrWQd32Ae-Pxh8MTyeoIuNl2wBk3RMmiv6AYEgTXGXxq8V2mWDW70UXcfRkVbqeaDTubcqkrocW1bxI9Y9vEJy64ICpL0Qx5vM-M5PVY77g95eCvEPFNLMMT-F0Odn3Cp3yadQLpPqowzV2DdcmxB-i548DB6en2l3T7db_iR3KSSx0ccHi_vvOaSve1KFObOncAIFmWxDL0-aRHdViaChsj5Kj01LSyNgo-7oi3zyhq9FyjrPuSMukgZvffFl70koU7UZjW2r9WcXdPyApvGbFS3DnMJUK0SxbCvxL6JPzUg9S0KI_r4ZzPw2kiMwOJyUiwN3CPQAnTSThemVVftlzIGzvmvo02amC5vPykzfbqRcWsn1-37845G6Tp3obyDDXBepcp85nyGv8CNRQKGwlMYyaqZDxxk"
        
        credentials.token = try! decode(jwt: token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetIbanInformation() {
        
        var ibanInformation: PSIbanInformation?
        let expectation = XCTestExpectation(description: "iban information should be not nil")
        
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
    
        let createPaymentCard = PSCreatePaymentCard(cardOwnerId: 1001,
                                                    shippingAddress: PSPaymentCardShippingAddress.init(postalCode: "9999999999", address: "test", city: "Kaunas", country: "Lithuania"),
                                                    accountOwnerId: 1001,
                                                    chargeInfo: PSChargeInfo.init(accountNumber: "EVP1610001845744"),
                                                    deliveryType: "registered_post")

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
        
        var cardsFilter = PSGetPaymentCardsFilter()
        var expectedCards: [PSPaymentCard]?
        
        //  cardsFilter.limit = 25
        //  cardsFilter.offset = 0
        //  cardsFilter.orderBy = "createdAt"
        //  cardsFilter.accountNumbers = ["EVP1610001845744"]
        //  cardsFilter.orderDirection = "asc"
        //  cardsFilter.statuses = ["ordered"]
        //  cardsFilter.cardOwnerId = "451745"
        cardsFilter.accountOwnerId = "451745"
        
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
