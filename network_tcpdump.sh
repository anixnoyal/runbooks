
tcpdump -i any 'port 8080 or port 8001'
tcpdump -i any -w capture.pcap 'port 8080 or port 8001'

#Capture only a specific number of packets:
tcpdump -i eth0 -c 10

#Capture and save packets to a file:
tcpdump -i eth0 -w packets.pcap

#Read packets from a file:
tcpdump -r packets.pcap

#Capture packets with a specific source or destination IP
tcpdump -i eth0 src 192.168.1.1
tcpdump -i eth0 dst 192.168.1.1

#Capture packets with a specific source or destination port:
tcpdump -i eth0 port 80
tcpdump -i eth0 src port 80
tcpdump -i eth0 dst port 80

#Capture packets of a specific protocol (e.g., TCP, UDP, ICMP):
tcpdump -i eth0 icmp
tcpdump -i eth0 tcp
tcpdump -i eth0 udp

#Capture packets with a specific IP and port:
tcpdump -i eth0 'src 192.168.1.1 and port 80'
tcpdump -i eth0 'dst 192.168.1.1 and port 80'

#Capture packets with complex expressions:
tcpdump -i eth0 'tcp[tcpflags] & (tcp-syn|tcp-ack) == tcp-syn'
tcpdump -i eth0 'src 192.168.1.1 and (dst port 80 or dst port 443)'

#Capture packets with a specific TCP flag set (e.g., SYN, ACK, FIN):
tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0'
tcpdump -i eth0 'tcp[tcpflags] & tcp-ack != 0'
tcpdump -i eth0 'tcp[tcpflags] & tcp-fin != 0'

#Capture packets with a specific packet size range:
tcpdump -i eth0 'less 64'
tcpdump -i eth0 'greater 128'
tcpdump -i eth0 'len >= 64 and len <= 128'

#Capture packets with verbose output:
tcpdump -i eth0 -v
tcpdump -i eth0 -vv
tcpdump -i eth0 -vvv

#Filter packets by MAC address:
tcpdump -i eth0 ether src 00:11:22:33:44:55
tcpdump -i eth0 ether dst 00:11:22:33:44:55


# Network Connectivity Issues
#Capture traffic on the server's network interface and filter by the client's IP and the server's port:
tcpdump -i eth0 host 192.168.1.10 and port 80
    "Look for SYN packets from the client and SYN-ACK packets from the server. If you don't see SYN-ACK packets, the server might not be listening on the port or a firewall could be 
    blocking the connection"

#High Latency or Packet Loss
tcpdump -i eth0 'tcp[tcpflags] & (tcp-ack|tcp-syn|tcp-fin) != 0'

    "Capture traffic and look for retransmissions and duplicate acknowledgments, which can indicate packet loss:"
    "Check for ICMP messages like "Destination Unreachable" or "Time Exceeded," which can indicate routing issues or TTL problems."

#DNS Issues
tcpdump -i eth0 port 53

    "Capture DNS traffic to see if DNS requests are being sent and if responses are received:"
    "Look for DNS query packets and corresponding DNS response packets. If there are no responses, there might be a DNS server issue"

#Firewall or Security Device Blocking
tcpdump -i eth0 host 192.168.1.10

    "Capture traffic on both sides of the firewall/security device to see if packets are being dropped or modified:"
    "Compare the captured traffic to see if there are discrepancies, which could indicate that the firewall or security device is blocking or altering the traffic."

 #Suspicious or Malicious Activity
 tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0'

    "Capture traffic and look for unusual patterns or known signatures of malicious activity:"
    "Analyze traffic for patterns like excessive SYN packets (potential SYN flood attack) or traffic to unusual ports (potential backdoor or command and control communication)."
