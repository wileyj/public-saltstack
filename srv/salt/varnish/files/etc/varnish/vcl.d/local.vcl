backend local {
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
    new local_vdir = directors.round_robin();
    local_vdir.add_backend(local);
}

sub vcl_recv {
    if (req.http.Host == "local.com"){
        set req.backend_hint = local_vdir.backend();
    }
}
