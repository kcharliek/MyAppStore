//
//  API+Lookup.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


extension API {

    struct Lookup: AppStoreAPIRequestGet {

        var path: String = "/lookup"
        var parameters: [String : Any] {
            [
                "country": "kr",
                "media": "software",
                "id": "\(trackId)"
            ]
        }
        var responseType = LookupAPIResponse.self

        private var trackId: Int

        init(trackId: Int) {
            self.trackId = trackId
        }

    }

}

struct LookupAPIResponse: Decodable {

    let resultCount: Int
    let results: [AppResponse]

}

/*
 response: ["resultCount": 1, "results": <__NSSingleObjectArrayI 0x6000010103a0>(
 {
     advisories =     (
     );
     appletvScreenshotUrls =     (
     );
     artistId = 284417353;
     artistName = Apple;
     artistViewUrl = "https://apps.apple.com/kr/developer/apple/id284417353?mt=12&uo=4";
     artworkUrl100 = "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/58/df/49/58df49cb-f2d3-8bc8-31d1-b1e206abf98a/source/100x100bb.jpg";
     artworkUrl512 = "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/58/df/49/58df49cb-f2d3-8bc8-31d1-b1e206abf98a/source/512x512bb.jpg";
     artworkUrl60 = "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/58/df/49/58df49cb-f2d3-8bc8-31d1-b1e206abf98a/source/60x60bb.jpg";
     averageUserRating = "4.7504400000000002179945113311987370252";
     averageUserRatingForCurrentVersion = "4.7504400000000002179945113311987370252";
     bundleId = "com.apple.TestFlight";
     contentAdvisoryRating = "4+";
     currency = KRW;
     currentVersionReleaseDate = "2021-01-25T19:10:44Z";
     description = "TestFlight\Ub97c \Uc0ac\Uc6a9\Ud558\Uba74 iOS, tvOS \Ubc0f watchOS\Uc6a9 \Uc571\Uc758 \Ubca0\Ud0c0 \Ubc84\Uc804 \Ubc0f \Uc571 \Ud074\Ub9bd\Uc744 \Uc190\Uc27d\Uac8c \Ud14c\Uc2a4\Ud2b8\Ud558\Uace0, \Ud574\Ub2f9 \Uc571\Uc774 App\U00a0Store\Uc5d0 \Ucd9c\Uc2dc\Ub418\Uae30 \Uc804\Uc5d0 \Uac1c\Ubc1c\Uc790\Uc5d0\Uac8c \Uc18c\Uc911\Ud55c \Ud53c\Ub4dc\Ubc31\Uc744 \Uc81c\Uacf5\Ud560 \Uc218 \Uc788\Uc2b5\Ub2c8\Ub2e4. \Uac1c\Ubc1c\Uc790\Ub294 \Uc774\Uba54\Uc77c \Ub610\Ub294 \Uacf5\Uac1c \Ub9c1\Ud06c\Ub97c \Ud1b5\Ud574 \Ud14c\Uc2a4\Ud130\Ub97c \Ucd08\Ub300\Ud569\Ub2c8\Ub2e4.\n\n\Ubca0\Ud0c0 \Uc571 \Ub610\Ub294 \Uc571 \Ud074\Ub9bd\Uc744 \Ud14c\Uc2a4\Ud2b8\Ud558\Ub294 \Uacbd\Uc6b0 Apple\Uc774 \Ucda9\Ub3cc \Ub85c\Uadf8, \Uc0ac\Uc6a9 \Uc815\Ubcf4 \Ubc0f \Uc0ac\Uc6a9\Uc790\Uac00 \Uc81c\Ucd9c\Ud55c \Ud53c\Ub4dc\Ubc31\Uc744 \Uc218\Uc9d1\Ud558\Uace0 \Uac1c\Ubc1c\Uc790\Uc5d0\Uac8c \Uc804\Uc1a1\Ud569\Ub2c8\Ub2e4. \Uac1c\Ubc1c\Uc790\Uac00 \Uc790\Uc0ac\Uc758 \Uc571 \Ubc0f \Uad00\Ub828 \Uc81c\Ud488\Uc744 \Ud5a5\Uc0c1\Ud558\Uae30 \Uc704\Ud574 \Uc774 \Uc815\Ubcf4\Ub97c \Uc0ac\Uc6a9\Ud560 \Uc218 \Uc788\Uc2b5\Ub2c8\Ub2e4. Apple\Uc774 \Uc81c\Ud488 \Ubc0f \Uc11c\Ube44\Uc2a4\Ub97c \Ud5a5\Uc0c1\Ud558\Uae30 \Uc704\Ud574 \Ucda9\Ub3cc \Ub85c\Uadf8 \Ubc0f \Uc0ac\Uc6a9 \Uc815\Ubcf4\Ub97c \Uc0ac\Uc6a9\Ud560 \Uc218 \Uc788\Uc2b5\Ub2c8\Ub2e4.\n\n\Uc124\Uce58, \Ud14c\Uc2a4\Ud2b8, \Ud53c\Ub4dc\Ubc31 \Uc81c\Ucd9c\Uc5d0 \Uad00\Ud55c \Uc124\Uba85 \Ubc0f \Uc0ac\Uc6a9\Uc790\Uc758 \Ub370\Uc774\Ud130 \Ucc98\Ub9ac \Ubc29\Ubc95\Uc5d0 \Uad00\Ud55c \Uc790\Uc138\Ud55c \Uc0ac\Ud56d\Uc740 testflight.apple.com \Uc0ac\Uc774\Ud2b8\Ub97c \Ucc38\Uc870\Ud558\Uc2ed\Uc2dc\Uc624.";
     features =     (
         iosUniversal
     );
     fileSizeBytes = 11192320;
     formattedPrice = "\Ubb34\Ub8cc";
     genreIds =     (
         6026
     );
     genres =     (
         "\Uac1c\Ubc1c\Uc790 \Ub3c4\Uad6c"
     );
     ipadScreenshotUrls =     (
         "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/9a/c9/74/9ac97445-7054-67eb-1da8-461a4d31a1fd/457d8086-8954-4229-b4b6-dbd2bdc659bb_iPad_Pro@2x.png/552x414bb.png",
         "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/56/c7/43/56c743df-2c95-dc51-cce1-07364f1b7dd1/contsched.nswlvjoc.png/552x414bb.png",
         "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/b6/08/48/b6084864-3202-b1e7-8833-cbcc2b50d6cc/d468641a-3244-4c65-b64f-8a1d20423ecd_iPad_Pro_App_Details_Copy@2x.png/552x414bb.png"
     );
     isGameCenterEnabled = 0;
     isVppDeviceBasedLicensingEnabled = 1;
     kind = software;
     languageCodesISO2A =     (
         AR,
         CA,
         HR,
         CS,
         DA,
         NL,
         EN,
         FI,
         FR,
         DE,
         EL,
         HE,
         HI,
         HU,
         ID,
         IT,
         JA,
         KO,
         MS,
         NB,
         PL,
         PT,
         RO,
         RU,
         ZH,
         SK,
         ES,
         SV,
         TH,
         ZH,
         TR,
         UK,
         VI
     );
     minimumOsVersion = "13.0";
     price = 0;
     primaryGenreId = 6026;
     primaryGenreName = "Developer Tools";
     releaseDate = "2014-09-09T22:23:57Z";
     releaseNotes = "\Uc548\Uc815\Uc131 \Ud5a5\Uc0c1 \Ubc0f \Uc624\Ub958 \Uc218\Uc815";
     screenshotUrls =     (
         "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/1e/2f/3c/1e2f3c7b-53c5-a23e-d692-507a43c1665f/contsched.gfgiyuog.png/392x696bb.png",
         "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/7b/16/6f/7b166f91-5109-9a18-a8eb-a0e6490425a9/c6ae49a8-6947-4281-a5e9-a69bfb93e0b0__U002bApp_Page_Copy@3x.png/392x696bb.png",
         "https://is1-ssl.mzstatic.com/image/thumb/Purple123/v4/8a/76/14/8a7614e8-c4b8-529d-61c6-cef87f68832e/contsched.fguzaezx.png/392x696bb.png",
         "https://is2-ssl.mzstatic.com/image/thumb/PurpleSource113/v4/ce/f8/be/cef8be75-b6e3-ba93-ed87-45493aed7ef2/db616d85-3a59-4b0e-8bad-b8ed0899bbfc__U002bPrevious_Builds_Copy@3x.png/392x696bb.png"
     );
     sellerName = "Apple Distribution International";
     sellerUrl = "http://developer.apple.com/kr/testflight/";
     supportedDevices =     (
         "iPhone5s-iPhone5s",
         "iPadAir-iPadAir",
         "iPadAirCellular-iPadAirCellular",
         "iPadMiniRetina-iPadMiniRetina",
         "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
         "iPhone6-iPhone6",
         "iPhone6Plus-iPhone6Plus",
         "iPadAir2-iPadAir2",
         "iPadAir2Cellular-iPadAir2Cellular",
         "iPadMini3-iPadMini3",
         "iPadMini3Cellular-iPadMini3Cellular",
         "iPodTouchSixthGen-iPodTouchSixthGen",
         "iPhone6s-iPhone6s",
         "iPhone6sPlus-iPhone6sPlus",
         "iPadMini4-iPadMini4",
         "iPadMini4Cellular-iPadMini4Cellular",
         "iPadPro-iPadPro",
         "iPadProCellular-iPadProCellular",
         "iPadPro97-iPadPro97",
         "iPadPro97Cellular-iPadPro97Cellular",
         "iPhoneSE-iPhoneSE",
         "iPhone7-iPhone7",
         "iPhone7Plus-iPhone7Plus",
         "iPad611-iPad611",
         "iPad612-iPad612",
         "iPad71-iPad71",
         "iPad72-iPad72",
         "iPad73-iPad73",
         "iPad74-iPad74",
         "iPhone8-iPhone8",
         "iPhone8Plus-iPhone8Plus",
         "iPhoneX-iPhoneX",
         "iPad75-iPad75",
         "iPad76-iPad76",
         "iPhoneXS-iPhoneXS",
         "iPhoneXSMax-iPhoneXSMax",
         "iPhoneXR-iPhoneXR",
         "iPad812-iPad812",
         "iPad834-iPad834",
         "iPad856-iPad856",
         "iPad878-iPad878",
         "iPadMini5-iPadMini5",
         "iPadMini5Cellular-iPadMini5Cellular",
         "iPadAir3-iPadAir3",
         "iPadAir3Cellular-iPadAir3Cellular",
         "iPodTouchSeventhGen-iPodTouchSeventhGen",
         "iPhone11-iPhone11",
         "iPhone11Pro-iPhone11Pro",
         "iPadSeventhGen-iPadSeventhGen",
         "iPadSeventhGenCellular-iPadSeventhGenCellular",
         "iPhone11ProMax-iPhone11ProMax",
         "iPhoneSESecondGen-iPhoneSESecondGen",
         "iPadProSecondGen-iPadProSecondGen",
         "iPadProSecondGenCellular-iPadProSecondGenCellular",
         "iPadProFourthGen-iPadProFourthGen",
         "iPadProFourthGenCellular-iPadProFourthGenCellular",
         "iPhone12Mini-iPhone12Mini",
         "iPhone12-iPhone12",
         "iPhone12Pro-iPhone12Pro",
         "iPhone12ProMax-iPhone12ProMax",
         "iPadAir4-iPadAir4",
         "iPadAir4Cellular-iPadAir4Cellular",
         "iPadEighthGen-iPadEighthGen",
         "iPadEighthGenCellular-iPadEighthGenCellular"
     );
     trackCensoredName = TestFlight;
     trackContentRating = "4+";
     trackId = 899247664;
     trackName = TestFlight;
     trackViewUrl = "https://apps.apple.com/kr/app/testflight/id899247664?uo=4";
     userRatingCount = 33932;
     userRatingCountForCurrentVersion = 33932;
     version = "3.0.1";
     wrapperType = software;
 }
 )
 ]
 (lldb)
 */
