# Enterprise Systems & Operations Homelab

![Maintenance](https://img.shields.io/badge/Status-Active-brightgreen)
![Environment](https://img.shields.io/badge/Platform-Hyper--V%20%2F%20VirtualBox-blue)
![AD DS](https://img.shields.io/badge/Directory-Active%20Directory-blue)
![Linux](https://img.shields.io/badge/Linux-Ubuntu%20Server-orange)

## Executive Summary
A dual-environment (Windows Active Directory & Hardened Linux) enterprise simulation designed to mirror small-to-medium enterprise (SME) infrastructure. This repository documents end-to-end administration, security policy deployment, configuration management, and tier-2/3 incident resolution workflows.

---

## Infrastructure Matrix

| Node Hostname | Role | Operating System | IP Address | Primary Services |
| :--- | :--- | :--- | :--- | :--- |
| **DC01** | Domain Controller / DNS | Windows Server 2022 | `192.168.50.10/24` | AD DS, DNS, Group Policy |
| **SRV-LNX01** | App & Utility Server | Ubuntu Server LTS | `192.168.50.20/24` | OpenSSH, UFW, Backup Cron |
| **WKSTN01** | Enterprise Client | Windows 10/11 Ent | `192.168.50.101/24` | Domain Member Client |

---

## Repository Contents

*   **[Network Architecture & Routing](docs/01-network-topology.md):** Hypervisor isolation, subnet allocations, and interface configurations.
*   **[Active Directory & GPO Administration](docs/02-active-directory-gpo.md):** OU design, security baselines, privilege mapping, and client joins.
*   **[Linux System Hardening & Scripts](docs/03-linux-server-hardening.md):** Key-based authentication, firewall management, and shell-scripted backup routines.
*   **[Incident Response & Troubleshooting Runbooks](docs/04-incident-response-troubleshooting.md):** Root-cause analysis (RCA) tickets for DNS dropouts, GPO misconfigurations, and firewall lockouts.

---

## Verification & Architecture Preview
```text
                  [ Hypervisor Virtual NAT / Host-Only Network ]
                                  192.168.50.0/24
                                         │
        ┌───────────────────────────────┼───────────────────────────────┐
        │                               │                               │
        ▼                               ▼                               ▼
┌───────────────────┐           ┌───────────────────┐           ┌───────────────────┐
│       DC01        │           │     SRV-LNX01     │           │      WKSTN01      │
│ Windows Server    │           │ Ubuntu Server     │           │ Windows Client    │
│ 192.168.50.10     │           │ 192.168.50.20     │           │ 192.168.50.101    │
│ (AD DS, DNS, GPO) │           │ (SSH, UFW, Cron)  │           │ (Domain Member)   │
└───────────────────┘           └───────────────────┘           └───────────────────┘
