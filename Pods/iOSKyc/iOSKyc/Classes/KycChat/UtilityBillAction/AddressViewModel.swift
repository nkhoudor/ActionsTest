//
//  AddressViewModel.swift
//  iOSKyc
//
//  Created by Nik on 07/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSBaseViews

class AddressViewModel {
    let form : TemplateFormConfig
    var images : [Data] = []
    
    init(form : TemplateFormConfig) {
        self.form = form
    }
    
    /*func getAddress(from addressInfoModel: AddressInfoModel) -> Address {
        //let inputs = ["Country", "City", "Region", "Street", "House number", "Postal code"]
        
        let country : String = addressInfoModel.value(for: "Country") ?? ""
        let city : String = addressInfoModel.value(for: "City") ?? ""
        let region : String = addressInfoModel.value(for: "Region") ?? ""
        let street : String = addressInfoModel.value(for: "Street") ?? ""
        let houseNumber : String = addressInfoModel.value(for: "House number") ?? ""
        let postalCode : String = addressInfoModel.value(for: "Postal code") ?? ""
        
        return Address(country: country, city: city, region: region, street: street, streetType: "", buildingNumber: houseNumber, apartmentNumber: "", postalCode: postalCode)
 	   }*/
}
