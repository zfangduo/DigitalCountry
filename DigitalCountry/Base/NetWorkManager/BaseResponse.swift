//
//  BaseResponse.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/14.
//

import UIKit

class BaseResponse: BaseModel {

    var code:Int?
    var message:String?
    var has_more:Int = 0
    var total_count:Int = 0
    
}
