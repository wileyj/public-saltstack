# simple static caching/reverse proxy for two backends
# need to incorporate legacy varnish configs in local2 (and elsewhere) for completeness
# too much caching is a bad thing....
#   - enable grace period in case backend is down
#   -
vcl 4.0;
import std;
import directors;

#backend default {
#   create a default backend to act as a catch-all for anything weird
#  .host = "127.0.0.1";
#  .port = "8080";
#}

backend local {
    .host = "172.17.0.3"; # this would be replaced by the ELB
    .port = "8080"; # ELB port
    .probe = {
        .url = "/index.html"; # url of the healthcheck
        # set the request header, so we know the check is coming from varnish and can filter out in logs
        .request =
            "HEAD / HTTP/1.1"
            "Host: localhost"
            "Connection: close"
            "User-Agent: Varnish Health Probe";
        # don't create conflict with the ELB healthchecks; possibly check faster from ELB, and slower from varnish?
        .interval = 5s;
        .timeout = 1s;
        .window = 5;
        .threshold = 3;
    }
    # backend connection defaults
    .first_byte_timeout     = 300s;
    .connect_timeout        = 5s;
    .between_bytes_timeout  = 2s;
}

backend local2 {
    .host = "172.17.0.3"; # this would be replaced by the ELB
    .port = "8081"; # ELB port
    .probe = {
        .url = "/index.html"; # url of the healthcheck
        # set the request header, so we know the check is coming from varnish and can filter out in logs
        .request =
            "HEAD / HTTP/1.1"
            "Host: localhost"
            "Connection: close"
            "User-Agent: Varnish Health Probe";
        # don't create conflict with the ELB healthchecks; possibly check faster from ELB, and slower from varnish?
        .interval = 5s;
        .timeout = 1s;
        .window = 5;
        .threshold = 3;
    }
    # backend connection defaults
    .first_byte_timeout     = 300s;
    .connect_timeout        = 5s;
    .between_bytes_timeout  = 2s;
}

acl purge {
    # global purging rules: add relevant office ip's etc to this list
    # this is used in the vcl_recv directive
    "localhost";
    "127.0.0.1";
    "::1";
}

sub vcl_init {
    new local_vdir = directors.round_robin();
    local_vdir.add_backend(local);
    new local2_vdir = directors.round_robin();
    local2_vdir.add_backend(local2);
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
    # create rules on where to send traffic based on host requested.
    # these need to be defined in the vc_init directive, else should go to a global default if nothing matches
    if (req.http.Host == "local.com"){
        # send all requests for 'local.com' to the local_vdir backend
        set req.backend_hint = local_vdir.backend();
    }
    elseif (req.http.Host == "local2.com"){
        # send all requests for 'local2.com' to the local2_vdir backend
        set req.backend_hint = local2_vdir.backend();
    }else{
        # send all unmatched requests to the local_vdir backend for now
        set req.backend_hint = local_vdir.backend();
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
}

sub vcl_backend_response {

}

sub vcl_deliver {
    # Add debug header to see if it's a HIT/MISS and the number of hits, disable when not needed
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
    # remove all unwanted header items. list should remove more in teh future because black hats are clever and are assholes
    set resp.http.X-Cache-Hits = obj.hits;
    unset resp.http.X-Powered-By;
    unset resp.http.Server;
    unset resp.http.X-Drupal-Cache;
    unset resp.http.X-Varnish;
    unset resp.http.Via;
    unset resp.http.Link;
    unset resp.http.X-Generator;
    return (deliver);
}
