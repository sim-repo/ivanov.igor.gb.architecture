//
//  LogServiceProxy.swift
//  homeWork_1
//
//  Created by Igor Ivanov on 22.09.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

class LogServiceProxy: AlamofireServiceProxy {
    
    func getFriends(delegate: VkApiFriendsDelegate) {
        print("getFriends")
        AlamofireService.instance.getFriends(delegate: delegate)
    }
    
    func getGroups(delegate: VkApiGroupsDelegate) {
        print("getGroups")
        AlamofireService.instance.getGroups(delegate: delegate)
    }
    
    func leaveGroup(gid: Int, delegate: VkApiGroupsDelegate) {
        print("leaveGroup")
        AlamofireService.instance.leaveGroup(gid: gid, delegate: delegate)
    }
    
    func joinGroup(gid: Int, delegate: VkApiGroupsDelegate) {
        print("joinGroup")
        AlamofireService.instance.joinGroup(gid: gid, delegate: delegate)
    }
    
    func searchGroups(search: String, delegate: VkApiGroupsDelegate) {
        print("searchGroups")
        AlamofireService.instance.searchGroups(search: search, delegate: delegate)
    }
    
    func getPhotos(delegate: VkApiPhotosDelegate) {
        print("getPhotos")
        AlamofireService.instance.getPhotos(delegate: delegate)
    }
    
    func getPhotosBy(_ id: Int, delegate: VkApiPhotosDelegate) {
        print("getPhotosBy")
        AlamofireService.instance.getPhotosBy(_ id: id, delegate: delegate)
    }
    
    func getNews(startFrom: String, delegate: VkApiFeedsDelegate) {
        print("getNews")
        AlamofireService.instance.getNews(startFrom: startFrom, delegate: delegate)
    }
    
    func getComments(ownerId: Int, postId: Int, delegate: VkApiCommentsDelegate){
        print("getComments")
        AlamofireService.instance.getComments(ownerId: ownerId, postId: postId, delegate: delegate)
    }
}
