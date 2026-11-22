# Project 24: Manual Chaos Test — Incident & Recovery Notes

## 1. Incident Summary
- **Date:** November 22, 2026
- **Target Host / Service:** `AZLTT0222435e27` / `amazon-cloudwatch-agent`
- **Chaos Scenario:** Controlled manual termination of the log forwarding daemon (`systemctl stop amazon-cloudwatch-agent`) to verify failure detection, service restoration, and recovery time.
- **Severity:** SEV-2 (Simulated Telemetry Outage)

## 2. Incident Timeline (UTC)

| Timestamp (UTC) | Event / Action Taken | Observed System State |
| :--- | :--- | :--- |
| `07:42:00Z` | **Baseline Health Check** | Service status verified as `active`. |
| `07:42:01Z` | **Chaos Injection (`systemctl stop`)** | Service stopped; status returned `inactive` (`Simulated Outage`). |
| `07:42:06Z` | **Recovery Initiated (`systemctl start`)** | Manual service restart executed after 5-second downtime window. |
| `07:42:07Z` | **Post-Recovery Verification** | Service status confirmed `active` and resuming log ingestion. |

## 3. Recovery Metrics & Lessons Learned
- **Total Downtime (MTTR):** ~6 seconds
- **Data Loss:** Zero (CloudWatch Agent state offset file preserved log position during brief outage).
- **Preventive Action:** Configure systemd `Restart=always` and `RestartSec=5` to ensure automatic self-healing if the daemon crashes unexpectedly.
