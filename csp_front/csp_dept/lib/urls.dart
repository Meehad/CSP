// ignore_for_file: non_constant_identifier_names

Uri loginurl = Uri.parse("http://10.0.2.2:8000/csp_log/dlogin/");

Uri eventUrl = Uri.parse("http://10.0.2.2:8000/feedback/event/");

Uri showfeeds(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/feedback/feedbyevent/$id/");
  return u;
}

Uri showEvents = Uri.parse("http://10.0.2.2:8000/feedback/events_view/");

Uri showQ = Uri.parse("http://10.0.2.2:8000/questions/");

Uri showans(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/answer/$id/");
  return u;
}

Uri survey_create = Uri.parse('http://10.0.2.2:8000/survey_create/');

Uri showop(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/options/$id/");
  return u;
}

Uri showavgfeed(String id) {
  Uri u = Uri.parse("http://10.0.2.2:8000/feedback/avg_feed/$id/");
  return u;
}

// Uri loginurl = Uri.parse("http://192.168.0.187:8000/csp_log/dlogin/");

// Uri eventUrl = Uri.parse("http://192.168.0.187:8000/feedback/event/");

// Uri showfeeds(String id) {
//   Uri u = Uri.parse("http://192.168.0.187:8000/feedback/feedbyevent/$id/");
//   return u;
// }

// Uri showEvents = Uri.parse("http://192.168.0.187:8000/feedback/events_view/");

// Uri showQ = Uri.parse("http://192.168.0.187:8000/questions/");

// Uri showans(String id) {
//   Uri u = Uri.parse("http://192.168.0.187:8000/answer/$id/");
//   return u;
// }

// Uri survey_create = Uri.parse('http://192.168.0.187:8000/survey_create/');

// Uri showop(String id) {
//   Uri u = Uri.parse("http://192.168.0.187:8000/options/$id/");
//   return u;
// }

// Uri showavgfeed(String id) {
//   Uri u = Uri.parse("http://192.168.0.187:8000/feedback/avg_feed/$id/");
//   return u;
// }
