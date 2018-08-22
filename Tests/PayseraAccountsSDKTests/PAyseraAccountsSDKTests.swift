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
        let token =  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE1MzQ5NjY1ODUsImp0aSI6IkVBbTNpcEZHMTlXUmJFTHVrc2RVZTBJeWlCWVI0NXNXIiwicHNyOnMiOlsibG9nZ2VkX2luIiwiY29uZmlybWVkX2xvZ19pbiJdLCJwc3I6dSI6IjQ1MTc0NSIsInBzcjpzaWQiOiJ5ZDRyNGRBUmFlX3B2RVJiY1dONVZncmk1Y3ZYNTFoUyIsInBzcjphIjp7InVzZXJfaWQiOiI0NTE3NDUifSwiaWF0IjoxNTM0OTIzMzg1fQ.rRxsUV1_EB_YkOW66tKYuJJKTYfGvHEVdwdTqgSWNjZbjWfCF7kttSgoRVrgwPgPTtsXiFPkFB994gk8e_LcAkw2_5D3SsqACyGjcRaSwL_Lairu2dw5_Eu0fzzWVBDKVGtJcoO3put5JPSzNx5dStsbYxmC9etKv3G8rs8mbLWcscgVp7-Z2zyqe-DiultWQqWtS0Ht7bIzTRsJfhhBDshbjuyhoj-lulHUZrVDMXsfJJsPqXCpdgww-zErbEyavU29ufPuMzsE06PF4flVzKroXT4Su72LrG9bky4Qz14dnLkAz0RzhQiMdilb6EmvFWc1Gx7EzugNBTIy1dUlCWt6aw-bkLepAXDmFzEC25nNrMEakiNrnzzwmXIq8iCne5JQBtx0ddJXUocEw79VSA4fEEDGFNrEEf4juWp7ikKxBqri3px1Ckb9QoxVAzGw95ufFrVe6_-wRQ8glOmmqq6KjK77zItKy6RpYYvNJASj3Cv0nKLeCwRcicYIpwjfjqigWYIitBfGKj3-oDKNBauILOPwGGVEkirntg52oGOI_XgFhfq5wH7m7JLqsD3wvKHMEHJKlxFUst7oa30b8Zrs3yX719rrgNI2_uo-5Mp9dEuFvUWCcDRfvEProm6LmUdZVek5cSpSoLCIRpqmkV99S91pdauh5EfHDRP9kQA"
        
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
    
    
    func testGetCardLimit() {
        
        var cardLimit: PSPaymentCardLimit?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.getPaymentCardLimit(accountNumber: "EVP1610001845744").done { paymentCardLimit in
            cardLimit = paymentCardLimit
            
            print("\n")
            print(paymentCardLimit.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(cardLimit)
    }
    
    func testSetCardLimit() {
        
        var cardLimit: PSPaymentCardLimit?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.setPaymentCardLimit(accountNumber: "EVP1610001845744",
                                              cardLimit: PSUpdatePaymentCardLimirRequest.init(amount: 850, currency: "EUR"))
            .done { paymentCardLimit in
            cardLimit = paymentCardLimit
            
            print("\n")
            print(paymentCardLimit.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(cardLimit)
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
