const mainUrl = 'http://20.197.17.192';

class Url {
  static const login = '$mainUrl/api/v1/login';
  static const nearbyDonor = '$mainUrl/api/v1/donors/';
  static const forgetPassword = '$mainUrl/api/v1/forgot-password';
  static const resetPassword = '$mainUrl/api/v1/reset-password';
  static const verifyotp = '$mainUrl/api/v1/verify-otp';
  static const getImage = "$mainUrl/get-image/";
  static const register = "$mainUrl/api/v1/donors/register";
  static const hospitalregister = "$mainUrl/api/v1/hospitals/register";
  static const getEmergencyRequest = "$mainUrl/api/v1/emergency-requests";
  static const postEmergencyRequest = "$mainUrl/api/v1/emergency-requests/";
  static const uploadImage = "$mainUrl/upload-image";
  static const getCampaings = "$mainUrl/api/v1/campaigns";
  static const postCampaings = "$mainUrl/api/v1/campaigns/";
  static const getAllhospitals = "$mainUrl/api/v1/hospitals/";
  static const readUser = "$mainUrl/api/v1/profile";
  static const getdonor = "$mainUrl/api/v1/donors/";
  static const gethospitaldetail = "$mainUrl/api/v1/hospitals/";
  static const getRewards = "$mainUrl/api/v1/rewards/";
  static const getRedeem = "$mainUrl/api/v1/redeem";
  static const getRedeemdDonors = "$mainUrl/api/v1/hospital-redeem";
}
