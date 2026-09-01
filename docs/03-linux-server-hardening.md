# Phase 3: Ubuntu Server Hardening & Automation

## System Profile
* **Hostname:** `SRV-LNX01`
* **OS:** Ubuntu Server LTS
* **IP Address:** `192.168.50.20/24`
* **Role:** Operations Utility & Log Repository

---

## Hardening Controls Implemented

### 1. SSH Remote Management Security
* **Authentication Scheme:** Ed25519 cryptographic keypairs (`256-bit`).
* **Root Access:** `PermitRootLogin no` enforced.
* **Password Authentication:** Disabled globally in `/etc/ssh/sshd_config.d/99-hardened.conf`.
* **Connection Throttling:** Capped at `MaxAuthTries 3`.

### 2. Host Firewall (UFW) Configuration
```text
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     LIMIT IN    Anywhere                   # SSH Rate Limited
53/udp on ens33            ALLOW IN    192.168.50.0/24            # Lab Internal DNS
Anywhere                   ALLOW IN    Anywhere (ICMP)            # Allow ICMP Echo
