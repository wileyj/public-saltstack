include "/etc/varnish/vcl.d/local2.vcl";
include "/etc/varnish/vcl.d/local.vcl";

acl purge {
    "localhost";
    "127.0.0.1";
    "10.255.0.0"/16;
    "::1";
}

sub vcl_recv {
    set req.http.Host = regsub(req.http.Host, ":[0-9]+", "");
    if (req.method == "PURGE") {
        if (!client.ip ~ purge) { # purge is the ACL defined at the begining
            return (synth(405, "This IP is not allowed to send PURGE requests."));
        }
        return (purge);
    }
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }

    if (req.http.Authorization || req.http.Cookie) {
        return (pass);
    }

    if (req.http.If-None-Match) {
        return (pass);
    }

    if (req.http.Cache-Control ~ "no-cache") {
        ban(req.url);
    }

    if (req.url ~  "(\?|&)access_token=" ) {
        return (pass);
    }
    return (hash);
}

sub vcl_hash {
    hash_data(req.url);
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
    if (req.http.Cookie) {
        hash_data(req.http.Cookie);
    }
    if (req.http.X-Forwarded-Proto) {
        hash_data(req.http.X-Forwarded-Proto);
    }
}

sub vcl_backend_response {
    set beresp.do_esi = true;
    if (bereq.http.X-Cache == "PASS" || beresp.status == 403 || beresp.status == 420 || beresp.status == 429) {
        set beresp.uncacheable = true;
        set beresp.http.Cache-Control = "max-age=0";
        set beresp.http.X-Varnish-TTL = "0s";
        set beresp.http.Pragma = "no-cache";
        return(deliver);
    }
    if (beresp.status == 404 || beresp.status == 420 || beresp.status == 429 || beresp.status == 500 || beresp.status == 503) {
        set beresp.ttl = 10s;
        set beresp.http.Cache-Control = "max-age=10";
        set beresp.http.X-Varnish-TTL = "10s";
        return(deliver);
    }
}

sub vcl_deliver {
    if (obj.hits > 0) { # Add debug header to see if it's a HIT/MISS and the number of hits, disable when not needed
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
    set resp.http.X-Cache-Hits = obj.hits;
    unset resp.http.X-Powered-By;
    unset resp.http.Server;
    unset resp.http.X-Varnish;
    unset resp.http.Via;
    unset resp.http.Link;
    unset resp.http.X-Generator;
    return (deliver);
}
