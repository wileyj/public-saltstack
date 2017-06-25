backend moil {
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
    new moil_vdir = directors.round_robin();
    moil_vdir.add_backend(moil);
}

sub vcl_recv {
    if (req.http.Host == "moil.io"){
        set req.backend_hint = moil_vdir.backend();
    }
}
