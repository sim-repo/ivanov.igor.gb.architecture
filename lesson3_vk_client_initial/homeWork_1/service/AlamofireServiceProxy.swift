//
//  AlamofireServiceProxy.swift
//  homeWork_1
//
//  Created by Igor Ivanov on 22.09.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation


protocol AlamofireServiceProxy {
    func getFriends(delegate: VkApiFriendsDelegate)
    func getGroups(delegate: VkApiGroupsDelegate)
    func leaveGroup(gid: Int, delegate: VkApiGroupsDelegate)
    func joinGroup(gid: Int, delegate: VkApiGroupsDelegate)
    func searchGroups(search: String, delegate: VkApiGroupsDelegate)
    func getPhotos(delegate: VkApiPhotosDelegate)
    func getPhotosBy(_ id: Int, delegate: VkApiPhotosDelegate)
    func getNews(startFrom: String, delegate: VkApiFeedsDelegate)
    func getComments(ownerId: Int, postId: Int, delegate: VkApiCommentsDelegate)
}

