 
 
 curl -kI --http2 https://192.168.31.211:8443
 curl -kI --http1.1 https://192.168.31.211:8443

sample output:
[root@jenkins-master-01 ~]# curl -kI --http2 https://192.168.31.211:8443
HTTP/1.1 200 OK   < "CHECK HERE-------------------"
Date: Tue, 19 Mar 2024 18:17:54 GMT
X-Content-Type-Options: nosniff
Content-Type: text/html;charset=utf-8
Expires: Thu, 01 Jan 1970 00:00:00 GMT
Cache-Control: no-cache,no-store,must-revalidate
X-Hudson-Theme: default
Referrer-Policy: same-origin
Cross-Origin-Opener-Policy: same-origin
Set-Cookie: JSESSIONID.5d0c2cd3=node0m57dnvoqt3gpjqbhky2zqmzv2.node0; Path=/; Secure; HttpOnly
X-Hudson: 1.395
X-Jenkins: 2.440.1
X-Jenkins-Session: c2288a62
X-Frame-Options: sameorigin
Content-Length: 15429
