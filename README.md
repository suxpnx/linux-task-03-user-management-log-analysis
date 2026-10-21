# Linux Task 03 — User Management, Log Analysis & Permissions

**Lab:** Linux / Kali Linux  
**Activity:** User setup, text processing, permissions and ownership, and user management  
**Primary user:** `forensic01`

## Objectives

This practical follows the uploaded *Linux Task 03* handout:

1. Create `forensic01` with a home directory and `/bin/bash`, add it to `sudo`, and set a password.
2. Log in as `forensic01`, create `/home/forensic01/logs/`, and create a mock `sys_events.log` containing at least 20 lines.
3. Use `grep`, pipes, redirection, `less`, `head`, `tail`, and `cat` to inspect and filter logs.
4. Create `confidential.txt`, restrict its permissions, change its owner to `root`, and observe access as `forensic01`.
5. Create `guest1` and `guest2`, add `guest1` to `sudo`, and remove `guest2` including its home directory.
6. Keep the commands used, explanations, and screenshots as submission evidence.

> **Safety:** Run these commands only in your own Linux lab VM or another system where you have explicit administrator permission. User-management commands affect the operating system. Read each command before running it. Use a lab VM, not a shared/production computer.

## Repository layout

```text
Linux_Task_03_GitHub_Workflow/
├── README.md
├── commands_used.txt
├── .gitignore
├── docs/
│   └── command_explanations.md
├── scripts/
│   └── create_mock_logs.sh
├── reports/
│   ├── error_report.txt
│   └── root_user01_report.txt
├── evidence/
│   ├── logs/
│   ├── permissions/
│   └── user-management/
└── screenshots/
    └── README.md
```

The screenshot/evidence folders are intentionally empty until you capture your own terminal outputs. Do not submit fabricated screenshots.

## Before starting

- Take a VM snapshot if your virtualization software supports it.
- Open a terminal in Kali/Linux.
- You need an administrator account with `sudo` privileges for account creation and ownership changes.
- Password prompts do not display characters while you type; this is normal.
- If a user already exists, do not blindly repeat the creation command. Check first with `id forensic01` or `getent passwd forensic01`.

## Part 1 — Create and switch to `forensic01`

Run these commands from your administrator account:

```bash
sudo useradd -m -s /bin/bash forensic01
sudo usermod -aG sudo forensic01
sudo passwd forensic01
id forensic01
getent passwd forensic01
```

If `useradd` reports that the user already exists, inspect the account instead of creating it again.

Switch to the new account:

```bash
su - forensic01
whoami
pwd
```

Expected checks: `whoami` should print `forensic01`; `pwd` should normally print `/home/forensic01`.

## Part 2 — Create mock logs and analyse them

Create the log directory:

```bash
mkdir -p /home/forensic01/logs
cd /home/forensic01/logs
```

You can create the sample log with the included script:

```bash
bash /path/to/Linux_Task_03_GitHub_Workflow/scripts/create_mock_logs.sh
```

Replace `/path/to/` with the actual location of the extracted project. Alternatively, create `sys_events.log` manually using `cat > sys_events.log` and enter the sample records from the script, then press `Ctrl+D` to finish.

Inspect and filter the log:

```bash
grep "ERROR" sys_events.log
grep -E "root|user01" sys_events.log
grep "ERROR" sys_events.log | less
grep -E "root|user01" sys_events.log | less
grep "ERROR" sys_events.log > error_report.txt
grep -E "root|user01" sys_events.log > root_user01_report.txt
head -n 5 sys_events.log
tail -n 5 sys_events.log
cat sys_events.log
```

Press `q` to exit `less`. Confirm the reports and files:

```bash
wc -l sys_events.log
cat error_report.txt
cat root_user01_report.txt
ls -l
```

The mock log has 24 records. Keep the resulting files in `/home/forensic01/logs/` for the practical; the repository also includes example report outputs for reference.

## Part 3 — Permissions and ownership

As `forensic01`, create and restrict the confidential file:

```bash
cd /home/forensic01/logs
touch confidential.txt
chmod 600 confidential.txt
ls -l confidential.txt
```

`600` means the owner has read/write permission, while group and others have no permissions. Then change the owner to root:

```bash
sudo chown root:root confidential.txt
ls -l confidential.txt
```

Try to read or edit it as `forensic01`:

```bash
cat confidential.txt
echo "test entry" >> confidential.txt
```

Because the file is owned by `root` and has mode `600`, `forensic01` should receive a permission-denied error for ordinary read/write attempts. This is the expected learning observation. Do not use `sudo` for these two tests, because that would test root access instead.

## Part 4 — Temporary users

Run from an account with `sudo` privileges:

```bash
sudo useradd -m -s /bin/bash guest1
sudo useradd -m -s /bin/bash guest2
sudo passwd guest1
sudo passwd guest2
sudo usermod -aG sudo guest1
id guest1
id guest2
```

Delete `guest2` and its home directory as required:

```bash
sudo userdel -r guest2
getent passwd guest2
```

If `getent passwd guest2` prints nothing, the account entry is no longer present. `userdel -r` can warn if the user is logged in or owns files outside the home directory; investigate such warnings rather than forcing removal blindly. The handout does not ask you to delete `guest1`.

## Evidence and submission checklist

Capture real screenshots of your own terminal and save them in `screenshots/` or the relevant `evidence/` subfolder:

- [ ] `id forensic01`, account details, and successful switch to `forensic01`
- [ ] At least 20 log lines and `grep "ERROR"` results
- [ ] `grep -E "root|user01"` results and report files
- [ ] `head`, `tail`, and `cat` output
- [ ] `ls -l confidential.txt` before and after `chown`
- [ ] Permission-denied result when `forensic01` tries to read/write the root-owned file
- [ ] `id guest1` showing sudo group membership and confirmation that `guest2` was removed

Add a short caption or note for each screenshot so the reviewer knows which requirement it demonstrates.

## GitHub upload from Windows Git Bash

1. Extract this ZIP to a convenient folder, for example `Documents`.
2. On GitHub, create a **new empty repository** (for example `linux-task-03`). Do not initialize it with a README, license, or `.gitignore`, because this project already contains those files.
3. Open Git Bash and change directory to the extracted project folder. Example:

```bash
cd ~/Documents/Linux_Task_03_GitHub_Workflow
```

If your folder is elsewhere, use that actual path. In Git Bash, Windows `C:\Users\YourName\Documents` is usually represented as `/c/Users/YourName/Documents`.

4. Configure Git if this is your first use on this computer:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Use your own name and email address.

5. Initialize, commit, and push. Replace `YOUR-USERNAME` and `linux-task-03` with your GitHub username and repository name:

```bash
git init
git add .
git status
git commit -m "Add Linux Task 03 practical workflow"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/linux-task-03.git
git push -u origin main
```

If you already initialized this folder as a Git repository, do not run `git init` again without checking its state. If `origin` already exists, inspect it with `git remote -v` rather than adding a second remote.

GitHub may prompt you to authenticate through a browser or credential manager. Do not put your password or access token in this README or in any committed file.

## Notes

- `commands_used.txt` is a prepared command log/template based on the activity. Edit it to reflect the commands you actually ran and any differences/errors.
- `reports/` contains sample output derived from the included mock log. Your actual terminal output may differ.
- Keep personal data, passwords, access tokens, VM credentials, and unrelated system information out of screenshots and commits.
