Uri loginurl = Uri.parse("http://10.0.2.2:8000/csp_log/clogin/");

Uri showProfile(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/csp_log/$id/showprofile/");
  return u;
}

Uri showfeeds = Uri.parse("http://10.0.2.2:8000/feedback/feeds_view/");

Uri postfeed = Uri.parse("http://10.0.2.2:8000/feedback/feed/");

Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/events_view/");

Uri logouturl = Uri.parse("http://10.0.2.2:8000/csp_log/logout_user/");
// Uri loginurl = Uri.parse("http://192.168.1.25:8000/csp_log/clogin/");

// Uri profileurl =
//     Uri.parse("http://192.168.1.25:8000/csp_log/2012022022/showprofile");

// Uri logouturl = Uri.parse("http://192.168.1.25:8000/citizen/logout_user/");

Uri complainturl = Uri.parse("http://10.0.2.2:8000/complaint/cpost/");
