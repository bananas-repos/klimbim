// This is an example proxy.pac file which can be used as the proxy configuration by URL
//
// file syntax is javascript

// this is the return value if we do not use the proxy
var direct = "DIRECT";
// this is the return value if we use the proxy. 
// this returns multiple proxyies
var proxy = "PROXY 10.0.1.12:80; PROXY 10.0.1.10:80; PROXY 10.0.1.11:80";

function FindProxyForURL(url, host) {

	var lhost = host.toLowerCase();
	var resolved_ip = dnsResolve(host);
	host = lhost;

	var lurl = url.toLowerCase();
	url = lurl;

	if(isPlainHostName(host)) {
		return direct;
	}

	// local networks do not use a proxy
	if(
		(isInNet(resolved_ip, "10.0.0.0", "255.0.0.0")) || 
		(isInNet(resolved_ip, "192.168.0.0", "255.255.0.0")) ||
		(isInNet(resolved_ip, "127.0.0.1", "255.255.255.255"))
	) { 
		return direct; 
	}

	// the local network uses some special tlds
	if(     
		(host == "some.special.tld") ||
	    (host == "some.special.interne.tld") 
	) { 
		return direct;
	}

	return proxy;
}
