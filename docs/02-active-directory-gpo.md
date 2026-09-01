# Phase 2: Active Directory DS & Group Policy Implementation

## Directory Service Overview
* **Forest Root Domain:** `corp.homelab.local`
* **Domain Functional Level:** Windows Server 2022
* **Primary Domain Controller:** `DC01` (192.168.50.10)
* **Authoritative DNS Zone:** `corp.homelab.local` (Active Directory-Integrated)

---

## Organizational Unit (OU) Architecture

```text
DC=corp,DC=homelab,DC=local
└── OU=CORP_Enterprise
    ├── OU=Admin_Tier
    ├── OU=Departments
    │   ├── OU=Finance
    │   ├── OU=Human_Resources
    │   └── OU=Information_Technology
    ├── OU=Servers
    ├── OU=Service_Accounts
    └── OU=Workstations
