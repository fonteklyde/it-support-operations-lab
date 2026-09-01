# Phase 4: Incident Response & Operational Runbooks

This document contains standardized post-incident reports and root-cause analyses (RCA) for simulated enterprise outages resolved within the environment.

---

## Incident Report: INC-1001

| Field | Value |
| :--- | :--- |
| **Incident ID** | INC-1001 |
| **Severity** | High (Degraded Domain Operations) |
| **Impacted System** | `WKSTN01.corp.homelab.local` (Windows 10/11) |
| **Reported Issue** | Client unable to access mapped drive `S:` and failed Group Policy synchronization. |

### 1. Initial Assessment & Symptoms
* User received network error when mounting `\\DC01\SharedData`.
* Running `gpupdate /force` returned error code `0x80070035` ("The network path was not found").
* Local ping to default gateway `192.168.50.1` succeeded, ruling out Physical and Data Link layer failures.

### 2. Diagnostic Path (OSI Layer Model)
* **Layer 3 (Network):** `ping 192.168.50.10` responded in `<1ms`.
* **Layer 7 (DNS / Application):**
  ```powershell
  PS C:\> Resolve-DnsName corp.homelab.local
  Resolve-DnsName : corp.homelab.local : DNS server failure
