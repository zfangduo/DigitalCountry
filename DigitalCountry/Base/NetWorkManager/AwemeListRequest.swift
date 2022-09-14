//
//  AwemeListRequest.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/14.
//

import UIKit

class AwemeListRequest: BaseRequest {

    var uid:String?
    var page:Int?
    var size:Int?
    
    static func findPostAwemesPaged(uid:String, page:Int, _ size:Int = 20, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let request = AwemeListRequest.init()
        request.uid = uid
        request.page = page
        request.size = size
        NetworkManager.getRequest(urlPath: FIND_AWEME_POST_BY_PAGE_URL, request: request, success: { data in
            if let response = AwemeListResponse.deserialize(from: data as? [String:Any]) {
                success(response)
            }
        }, failure: { error in
            failure(error)
        })
    }
    
    
    
}
