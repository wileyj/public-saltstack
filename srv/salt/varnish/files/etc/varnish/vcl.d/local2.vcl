backend local2 {
    .host = "localhost";
    .port = "8081";
    .probe = {
        .request =
            "HEAD / HTTP/1.1"
            "Host: localhost"
            "Connection: close"
            "User-Agent: Varnish Health Probe";
        .interval = 5s;
        .timeout = 1s;
        .window = 5;
        .threshold = 3;
    }
    .first_byte_timeout     = 300s;
    .connect_timeout        = 5s;
    .between_bytes_timeout  = 2s;
}

sub vcl_init {
    new local2_vdir = directors.round_robin();
    local2_vdir.add_backend(local2);
}

sub vcl_recv {
    if (req.http.Host == "local2.com"){
        set req.backend_hint = local2_vdir.backend();
        if (req.http.Cookie) {
            set req.http.Cookie = ";" + req.http.Cookie;
            set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
            set req.http.Cookie = regsuball(req.http.Cookie, ";(PHPSESSID|token|oauth)=", "; \1=");
            set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
            set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");
            # If no cookies remain, delete the empty header.
            if (req.http.Cookie == "") {
                unset req.http.Cookie;
            }
        }
        # TV-2533 - Srip ALL cookies, unless one these are there, in which case allow ALL cookies.
        if (req.http.Cookie !~ "(token|oauth)=") {
            unset req.http.Cookie;
        }
    #}else{
    #    set req.backend_hint = local_vdir.backend();
    }
}

sub vcl_backend_response {
    if (bereq.http.Host == "local2.com"){
        if (!(bereq.url ~ "login" || bereq.url ~ "logout" || bereq.url ~ "(\?|&)access_token=" || bereq.http.Authorization)) {
            unset beresp.http.Set-Cookie;
        }
    }
}
