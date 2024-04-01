

firewall-cmd --permanent --direct --add-rule ipv4 nat PREROUTING 0 -p tcp --dport 443 -j REDIRECT --to-ports 8443
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -p tcp --dport 8443 -j ACCEPT

firewall-cmd --reload

firewall-cmd --direct --get-all-rules
