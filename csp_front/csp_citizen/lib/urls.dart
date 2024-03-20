Uri loginurl = Uri.parse("http://10.0.2.2:8000/csp_log/clogin/");

Uri showProfile(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/csp_log/$id/showprofile/");
  return u;
}

Uri showfeeds = Uri.parse("http://10.0.2.2:8000/feedback/feeds_view/");

Uri postfeed = Uri.parse("http://10.0.2.2:8000/feedback/feed/");

Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/events_view/");

Uri showunfeeded(String id) {
  Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/feed_view/$id/");
  return showEvents;
}

Uri logouturl = Uri.parse("http://10.0.2.2:8000/csp_log/logout_user/");

Uri complainturl = Uri.parse("http://10.0.2.2:8000/complaint/cpost/");

Uri showQ = Uri.parse("http://10.0.2.2:8000/questions/");

Uri showRQ(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/$id/remaining_q/");
  return u;
}

Uri postSurvey = Uri.parse("http://10.0.2.2:8000/submit_survey/");

Uri showPdf = Uri.parse("http://10.0.2.2:8000/pdf/pdfview/");

Uri downloadpdf(int id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/pdf/download_pdf/$id/");
  return u;
}

// Uri loginurl = Uri.parse("http://192.168.1.8:8000/csp_log/clogin/");

// Uri showProfile(String id) {
//   Uri u = Uri.parse("http://192.168.1.8:8000/csp_log/$id/showprofile/");
//   return u;
// }

// Uri showfeeds = Uri.parse("http://192.168.1.8:8000/feedback/feeds_view/");

// Uri postfeed = Uri.parse("http://192.168.1.8:8000/feedback/feed/");

// Uri postfeed = Uri.parse("http://192.168.137.1:8000/feedback/feed/");

// Uri showunfeeded(String id) {
//   Uri showEvents = Uri.parse("http://192.168.137.1:8000/feedback/feed_view/$id/");
//   return showEvents;
// }

// Uri showEvents = Uri.parse("http://192.168.137.1:8000/feedback/events_view/");

// Uri logouturl = Uri.parse("http://192.168.1.8:8000/csp_log/logout_user/");

// Uri complainturl = Uri.parse("http://192.168.1.8:8000/complaint/cpost/");

// Uri showQ = Uri.parse("http://192.168.1.8:8000/questions/");

// Uri showRQ(String id) {
//   Uri u = Uri.parse("http://192.168.1.8:8000/$id/remaining_q/");
//   return u;
// }

// Uri postSurvey = Uri.parse("http://192.168.1.8:8000/submit_survey/");

// Uri showPdf = Uri.parse("http://192.168.1.8:8000/pdf/pdfview/");

// Uri downloadpdf(int id) {
//   Uri u = Uri.parse("http://192.168.1.8:8000/pdf/download_pdf/$id/");
//   return u;
// }