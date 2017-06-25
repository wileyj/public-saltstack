backend wileyj {
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
    new wileyj_vdir = directors.round_robin();
    wileyj_vdir.add_backend(wileyj);
}

sub vcl_recv {
    if (req.http.Host == "wileyj.net"){
        set req.backend_hint = wileyj_vdir.backend();
    }
}

sub vcl_backend_response {
    if (bereq.http.Host == "wileyj.net"){
        if (!(bereq.url ~ "login" || bereq.url ~ "logout" || bereq.url ~ "(\?|&)access_token=" || bereq.http.Authorization)) {
            unset beresp.http.Set-Cookie;
        }
    }
}
