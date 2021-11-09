//
//  Constant.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 25/10/2021.
//

import Foundation

class Constant {
    
    static var baseURLWithDebugging = "http://10.250.10.221:8083/IsbBarPortal.Api/" // Local Machine IP
    static var baseURL = "http://203.215.160.148:9545/" // live IP
    
//    static var baseURL = "http://172.16.1.234:9444/" // local IP
    static var imageDownloadURL = "\(baseURL)documents/"
    
    //MARK: - AccountModule
    
    static var registrationEP = "api/Account/Registration"
    static var loginEP = "api/Account/Login"
    static var verifyLisenceEP = "api/Account/VerifyLicense"
    
    //MARK: - UserModule
    
    static var getUsersEP = "api/User/GetUsers"
    static var getUserDetailByIdEP = "api/User/GetUserDetail"
    static var updateUserStatusEP = "api/User/UpdateUserStatus"
    static var updateUserEP = "api/User/UpdateUser"
    static var makeRemoveAdminEP = "api/User/MakeRemoveAdmin"
    
    //MARK: - MemberAnnouncementModule
    
    static var memPostAnnouncementEP = "api/MemberAnnouncement/PostAnnouncement"
    static var memPostAttachmentEP = "api/MemberAnnouncement/PostAttachement"
    static var memGetAnnounceEP = "api/MemberAnnouncement/GetAnnouncements"
    static var memGetAnnounceDetailsEP = "api/MemberAnnouncement/GetAnnouncementDetail"
    
    //MARK: - BarAnnouncementModule
    
    static var barPostAnnouncementEP = "api/BarAnnouncement/PostAnnouncement"
    static var barPostAttachmentEP = "api/BarAnnouncement/PostAttachement"
    static var barGetAnnounceEP = "api/BarAnnouncement/GetAnnouncements"
    static var barGetAnnounceDetailsEP = "api/BarAnnouncement/GetAnnouncementDetail"
    
    //MARK: - QuestionModule
    
    static var postQuestionEP = "api/Question/PostQuestion"
    static var quesPostAttachmentEP = "api/Question/PostAttachement"
    static var quesPostCommentEP = "api/Question/PostComment"
    static var getQuestionsEP = "api/Question/GetQuestions"
    static var getQuestionDetailsEP = "api/Question/GetQuestionDetail"
    static var delCommentsEP = "api/Question/DeleteComment"
    static var getCommentsEP = "api/Question/GetComments"
    static var searchQuestionEP = "api/Question/SearchQuestion"
    
    //MARK: - OfficialDirectoryModule
    
    static var getOfficialContactsEP = "api/OfficialDirectory/GetOfficialContacts"
    static var addOfficialContactsEp = "api/OfficialDirectory/AddOfficialContact"
    
    //MARK: - CensorWord
    
    static var addWord = "api/CensorWord/Add"
    
    //MARK: - downloadPDFUrl
    
    static var pdfDownloadUrl = "off_directory/Official_directory.pdf"
}
