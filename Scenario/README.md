# Scenario Q2
## 1. Verify DNS Resolution  
## **Problem**  
Users are experiencing a _" host not found"_ error, which may indicate a DNS resolution issue.  
To diagnose, we will compare DNS resolution using:  
- The system’s default resolver (`/etc/resolv.conf`)  
- Google's public DNS (`8.8.8.8`)  

## **Steps**  

### **1. Check System DNS Configuration**  
```bash
cat /etc/resolv.conf
```
### **2. Resolve the domain using the system's DNS**  
```bash
dig internal.example.com
```
### **3. Resolve the domain using Google's DNS (8.8.8.8):**  
```bash
dig internal.example.com
```
## **Expected Outcome**
1) If both DNS resolutions return the same IP address, DNS resolution is functioning correctly.
2) If the IP addresses differ, there may be an issue with the internal DNS server, and further investigation into its configuration is needed.

## **Resolution (if applicable)**
If the system's DNS is incorrect or unreachable, I would:
Update /etc/resolv.conf to point to a valid DNS server.
Restart DNS services using:
```bash
sudo systemctl restart systemd-resolved
```

## 2. Diagnose Service Reachability
## **Problem**
The web service may be up, but unreachable due to network misconfigurations or firewall issues. I will verify if the service is listening on ports 80 or 443 and if the service is reachable from the affected systems.

## **Steps**
Check if the service is listening on ports 80 and 443:

```bash
netstat -tuln | grep -E '80|443'
```
This will show if the web service (e.g., Nginx, Apache) is actively listening on the expected ports.

Check if the service is reachable via curl:
```bash
curl http://resolved_ip
curl https://resolved_ip
```
This will check if the web service responds correctly.

Test port reachability using telnet:

```bash
telnet resolved_ip 80
telnet resolved_ip 443
```
## **Expected Outcome**
If the service is listening and reachable, the commands should return successful results (e.g., an HTTP response or open port).

If not, it could indicate a firewall issue, a misconfigured web server, or other network problems.

## **Resolution (if applicable)**
If the service is not listening on the required ports, I would:
Restart the web server:
```bash
sudo systemctl restart nginx  # or apache2
```
If the service is behind a firewall, I would:
Open the necessary ports using ufw or iptables:
```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```
## 3. Trace the Issue – List All Possible Causes
## **Problem**
Even though the service is up, it might still be unreachable due to a variety of reasons. I will consider multiple layers of potential causes.
## **Possible Causes**
1) DNS Resolution Issues:
.)Internal DNS misconfiguration or caching issues.
.) The DNS server might not be reachable.
2) Firewall Issues: The server’s firewall or a network firewall may be blocking traffic on the required ports (80/443).
3) Network Configuration Issues: Misconfigured routes, wrong subnets, or incorrect gateway settings could prevent proper communication.
4) Web Service Misconfiguration: The web service may not be configured to listen on the correct IP or ports.
5) DNS Cache Issues: Local DNS cache on the client machines could be outdated, leading to resolution failures.
## **Resolution**
For each of these, I will check logs (e.g., /var/log/syslog, nginx or apache2 logs) and run diagnostic commands like ss, iptables -L, netstat, and dig to pinpoint the root cause.


## 🏆Bonus
## **Configure a Local /etc/hosts Entry**
1) For Testing DNS Resolution: Edit /etc/hosts to directly map internal.example.com to the resolved IP address, bypassing DNS.
```bash
sudo nano /etc/hosts
# Add the following entry:
resolved_ip internal.example.com
```
2) Persist DNS Settings: For systemd-resolved:

```bash
sudo nano /etc/systemd/resolved.conf
# Add DNS settings:
DNS=8.8.8.8
```
3) Restart the resolver:

```bash
sudo systemctl restart systemd-resolved
```
4) For NetworkManager:

```bash
nmcli connection modify "your-connection" ipv4.dns "8.8.8.8"
nmcli connection up "your-connection"
```
