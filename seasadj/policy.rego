package envoy.authz

import input.attributes.request.http as req

default allow = false

allow {
	req.method == "GET"
	input.parsed_path = ["seasadj", "version"]
}

allow {
	req.method == "POST"
	array.slice(input.parsed_path, 0, 1) == ["seasadj"]
	basic_auth.user_name == "guest"
  basic_auth.password == "password"
}

basic_auth := {"user_name": user_name, "password": password} {
	v := input.attributes.request.http.headers.authorization
	startswith(v, "Basic ")
	s := substring(v, count("Basic "), -1)
	[user_name, password] := split(base64url.decode(s), ":")
}