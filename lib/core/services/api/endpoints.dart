class EndPoints {
  static const String baseUrl = "http://10.0.2.2:5000/api/v1";

  /// 📧 Auth
  static const String signup = "/email/signup";
  static const String login = "/email/login";
  static const String forgetPassword = "/email/login-forget-password";
  static const String resetPassword = "/email/reset-password";

  /// 👤 Users
  static const String getUserTickets = "/users/Ticket/";
  static const String getStations = "/users/stations";
  static const String getTrips = "/users/trips";
  static const String getSeats = "/users/seats";
  static const String holdSeat = "/users/hold-seat";
  static const String createBooking = "/users/createBooking";

  /// 🚉 Admin - Trips
  static const String createTrip = "/admin/trip/create";
  static const String updateTrip = "/admin/trip/update/";
  static const String deleteTrip = "/admin/trip/delete/";
  static const String getTripById = "/admin/trip/";
  static const String getTripsByStation = "/admin/trip/station/";

  /// 🚄 Admin - Trains
  static const String createTrain = "/admin/train/create";
  static const String getTrainById = "/admin/train/";
  static const String getTrainByName = "/admin/train/name/";
  static const String getTrainsByStation = "/admin/train/station/";

  /// 💺 Admin - Seats
  static const String createSeat = "/admin/seat/create";
  static const String createSeatsBulk = "/admin/seats/bulk";
  static const String getSeatById = "/admin/seat/";

  /// 🏢 Admin - Stations
  static const String createStation = "/admin/station/create";
  static const String createStationsBulk = "/admin/stations/bulk";
  static const String getAllStations = "/admin/stations";
  static const String getStationById = "/admin/station/";
  static const String getStationByName = "/admin/station/name/";
}