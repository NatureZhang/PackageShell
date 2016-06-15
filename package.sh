
#设置证书 如果能从外部获取
Code_Sign_Identity="iPhone Distribution: xxxxx Information System Co., Ltd"

#工程名称
Project_Name="studyWebView.xcodeproj"
#Target名称
Target_Name="studyWebView"

cd Target_Name

Project_Plist=$Target_Name/Info.plist

#如果能从外界获取
Fixed_Project_BundleId="com.zhang.dong"

#写入Bundle Identifier
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $Fixed_Project_BundleId" ${Project_Plist}

#build
xcodebuild -project "$Project_Name" -target "$Target_Name" -configuration Release CODE_SIGN_IDENTITY="$Code_Sign_Identity" clean build

Build_Directory="./build/Release-iphoneos"

Build_Path="$Build_Directory/$Target_Name.app"

#info.plist位置
App_Infoplist_Path=${Build_Path}/Info.plist

# 取版本号
Version=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${App_Infoplist_Path})
# 取build值
BuildVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${App_Infoplist_Path})
# 取displayName
DisplayName=$(/usr/libexec/PlistBuddy -c "print CFBundleName" ${App_Infoplist_Path})
# IPA名称
IPA_Name="${DisplayName}_${Version}(${BuildVersion})_$(date +"%Y%m%d")"
# 导出IPA文件
IPA_Path="/Users/tw/Desktop/TestShell"
Export_Path="$IPA_Path/$IPA_Name.ipa"


xcrun -sdk iphoneos -v PackageApplication "$Build_Path" -o "$Export_Path"

