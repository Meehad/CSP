Uri loginurl = Uri.parse("http://10.0.2.2:8000/csp_log/clogin/");

Uri showProfile(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/csp_log/$id/showprofile/");
  return u;
}

Uri showfeeds = Uri.parse("http://10.0.2.2:8000/feedback/feeds_view/");

Uri postfeed = Uri.parse("http://10.0.2.2:8000/feedback/feed/");

Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/events_view/");

Uri logouturl = Uri.parse("http://10.0.2.2:8000/csp_log/logout_user/");

Uri complainturl = Uri.parse("http://10.0.2.2:8000/complaint/cpost/");

Uri showQ = Uri.parse("http://10.0.2.2:8000/questions/");

Uri postSurvey = Uri.parse("http://10.0.2.2:8000/submit_survey/");