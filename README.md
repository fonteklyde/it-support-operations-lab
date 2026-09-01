# Enterprise Systems Administration & Operations Homelab

<div align="center">

![Platform](https://img.shields.io/badge/Platform-Hypervisor%20Isolated-blue?style=flat-square&logo=virtualbox)
![Windows Server](https://img.shields.io/badge/Windows%20Server-2022%20AD%20DS-0078D6?style=flat-square&logo=windows)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20LTS-E95420?style=flat-square&logo=ubuntu)
![Automation](https://img.shields.io/badge/Automation-Bash%20%2F%20PowerShell-4EAA25?style=flat-square&logo=gnubash)
![Security](https://img.shields.io/badge/Security-UFW%20%2F%20GPO%20Baselines-red?style=flat-square)

</div>

## Executive Summary
A production-grade enterprise simulation designed to mirror small-to-medium enterprise (SME) infrastructure. This repository provides operational documentation, configuration scripts, and ITIL-standard incident response runbooks demonstrating dual-environment administration across **Windows Active Directory Domain Services** and **Hardened Linux (Ubuntu Server)**.

---

## Technical Skills Demonstrated

* **Directory Services & Identity:** Active Directory Domain Services (AD DS), Forest/Domain Functional Levels, Multi-Tier OU Hierarchy Design, Role-Based Access Control (RBAC).
* **Policy & Endpoint Governance:** Group Policy Management (GPOs), Computer Inactivity Lockouts, Peripheral (USB) Restriction Policies, Network Drive Mapping with Item-Level Targeting.
* **Linux Systems Administration:** SSH Key-Pair Authentication (Ed25519), Root Hardening, Uncomplicated Firewall (UFW) State-Tracking, Shell Script Automation, and Cron Scheduling.
* **Network Infrastructure & Diagnostics:** Isolated Subnetting (`192.168.50.0/24`), Layer-4/Layer-7 DNS Troubleshooting, Static Netplan Routing, ICMP Diagnostics.
* **Operational Incident Response:** ITIL Root-Cause Analysis (RCA), OSI-layer troubleshooting methodology, Event Log and Journal Analysis.

---

## Infrastructure Matrix

| Node Hostname | Role | OS / Platform | IP Address | Key Services & Configuration |
| :--- | :--- | :--- | :--- | :--- |
| **DC01** | Domain Controller / DNS | Windows Server 2022 | `192.168.50.10/24` | AD DS (`corp.homelab.local`), DNS Zone, Group Policy |
| **SRV-LNX01** | App & Utility Server | Ubuntu Server 22.04 LTS | `192.168.50.20/24` | OpenSSH (Ed25519), UFW, Automated Bash Backup Cron |
| **WKSTN01** | Enterprise Client | Windows 10/11 Enterprise | `192.168.50.101/24` | Domain-joined client, GPO target |
| **Lab Gateway** | Virtual NAT Switch | Hypervisor Virtual Net | `192.168.50.1/24` | Outbound WAN NAT / Subnet Isolation |

---

## Documentation Runbooks

1. **[Network Topology & Hypervisor Segmentation](docs/01-network-topology.md)**
   * Subnet addressing plans, virtual switch isolation, and baseline inter-VM routing validation.
2. **[Active Directory DS & Group Policy Implementation](docs/02-active-directory-gpo.md)**
   * OU architecture, automated user provisioning via PowerShell, and security baseline GPOs.
3. **[Ubuntu Server Hardening & Automation](docs/03-linux-server-hardening.md)**
   * Passwordless SSH configuration, UFW ingress rules, and scheduled daily log backup scripts.
4. **[Incident Response & Troubleshooting Runbooks](docs/04-incident-response-troubleshooting.md)**
   * Documented incident tickets: **INC-1001** (DNS Resolution Breakdown) and **INC-1002** (SSH Firewall Ingress Lockout).

---

## Automated Scripts Directory

* **PowerShell Provisioning:** [`scripts/powershell/new-user-provisioning.ps1`](scripts/powershell/new-user-provisioning.ps1) — Bulk Active Directory user and department OU assignment.
* **Bash Backup Routine:** [`scripts/bash/automated-backup.sh`](scripts/bash/automated-backup.sh) — Tar/Gzip compression, retention rotation (7 days), and timestamped logging.

---

## Author & Contact
* **Specialist:** IT Support Specialist
* **LinkedIn:** [https://www.linkedin.com/in/klyde-dexter-fonte-2630292b7/](https://linkedin.com)
