#!/usr/bin/env bash
# Create a 24-line mock system event log in the current directory.
# Run this only in your own lab environment.
set -euo pipefail

cat > sys_events.log <<'LOGS'
2026-10-21 08:00:01 INFO system boot sequence started
2026-10-21 08:00:04 INFO user01 logged in from local console
2026-10-21 08:01:10 WARNING disk usage reached 75 percent
2026-10-21 08:02:33 ERROR failed login attempt for user01
2026-10-21 08:03:05 INFO service networking started
2026-10-21 08:04:19 WARNING repeated authentication failures detected
2026-10-21 08:05:42 ERROR permission denied while opening /var/log/secure
2026-10-21 08:06:00 INFO root ran a routine maintenance check
2026-10-21 08:07:11 INFO user01 opened the lab notes
2026-10-21 08:08:23 ERROR simulated service timeout
2026-10-21 08:09:17 WARNING memory usage reached 80 percent
2026-10-21 08:10:01 INFO scheduled task completed successfully
2026-10-21 08:11:44 ERROR invalid configuration in mock service
2026-10-21 08:12:09 INFO root reviewed system status
2026-10-21 08:13:31 WARNING new login location requires review
2026-10-21 08:14:56 INFO user01 signed out of the test session
2026-10-21 08:15:22 ERROR simulated file access failure
2026-10-21 08:16:08 INFO audit collection started
2026-10-21 08:17:43 WARNING temporary directory is nearly full
2026-10-21 08:18:30 INFO root completed the audit check
2026-10-21 08:19:15 ERROR simulated database connection failure
2026-10-21 08:20:02 INFO user01 signed in again for testing
2026-10-21 08:21:49 WARNING test service is using a fallback setting
2026-10-21 08:22:20 INFO mock log generation completed
LOGS

printf 'Created %s with %s lines.\\n' "sys_events.log" "$(wc -l < sys_events.log)"
