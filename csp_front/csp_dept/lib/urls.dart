Uri loginurl = Uri.parse("http://10.0.2.2:8000/csp_log/dlogin/");

Uri profileurl =
    Uri.parse("http://10.0.2.2:8000/csp_log/2012022022/showprofile");

Uri eventUrl = Uri.parse("http://10.0.2.2:8000/feedback/event/");

Uri showfeeds = Uri.parse("http://10.0.2.2:8000/feedback/feeds_view/");

Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/events_view/");

Uri showQ = Uri.parse("http://10.0.2.2:8000/questions/");

Uri showans(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/answer/$id/");
  return u;
}

Uri survey_create = Uri.parse('http://10.0.2.2:8000/survey_create/');

// Uri loginurl = Uri.parse("http://192.168.88.231:8000/csp_log/dlogin/");

// Uri profileurl =
//     Uri.parse("http://192.168.88.231:8000/csp_log/2012022022/showprofile");

// Uri eventUrl = Uri.parse("http://192.168.88.231:8000/feedback/event/");

// Uri showfeeds = Uri.parse("http://192.168.88.231:8000/feedback/feeds_view/");

// Uri showEvents = Uri.parse("http://192.168.88.231:8000/feedback/events_view/");

// Uri showQ = Uri.parse("http://192.168.88.231:8000/questions/");

// Uri showans(String id) {
//   Uri u = Uri.parse("http://192.168.88.231:8000/answer/$id/");
//   return u;
// }