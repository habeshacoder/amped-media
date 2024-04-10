class TokenManagment {
  String accessToken = '';
  String refreshToken = '';

  void updateTokens(String newAccessToken, String newRefreshToken) {}

  Future<String> getNewAccessToken() async {
    // Use the refresh token to obtain a new access token from the server
    return 'fadsdf';
  }

  Future<String> getAccessToken() async {
    if (accessToken.isEmpty || isTokenExpired()) {
      // If the access token is empty or expired, get a new access token
      return await getNewAccessToken();
    } else {
      // Return the current access token
      return accessToken;
    }
  }

  bool isTokenExpired() {
    return accessToken.isEmpty;
  }

}
