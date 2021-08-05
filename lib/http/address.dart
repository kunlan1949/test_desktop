class Address{

 //基本组成
 static String R = "120.24.58.226";
 static String T = "127.0.0.1";
 static String P = ":5000";
 //IP拼接
 static String R_IP = R + P;
 static String T_IP = T + P;
 //URL拼接
 static String R_URL = "http://"+R_IP;
 static String T_URL = "http://"+T_IP;



 ///用于全局配置的IP和URL
 ///远程服务器
 // static String OUT_IP = R_IP;//T_IP
 // static String OUT_URL = R_URL;
 // static String OUT = R;
 ///本地测试
 static String OUT_IP = T_IP;
 static String OUT_URL = T_URL;
 static String OUT = T;


 static String musicSheetUrl ="/api/music/RecommendedSongSheetAsync";

 static String getMusicSheet = OUT_URL+musicSheetUrl;

 // static var getDeviceUri = new Uri.http(OUT_IP,"/api/device/GetConnectedDevice");
 static String BASE_URL = "http://127.0.0.1:5000";
}