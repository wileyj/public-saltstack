backend site1 {
    .host = "localhost";
    .port = "8080";
    .probe = {
        #.url = "/index.html";
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
    new site1_vdir = directors.round_robin();
    site1_vdir.add_backend(site1);
}

sub vcl_recv {
    if (req.http.Host == "site1.com"){
        set req.backend_hint = site1_vdir.backend();
    }
}
