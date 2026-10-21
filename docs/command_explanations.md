# Required command explanations

## `grep`

`grep` searches input text for lines matching a pattern and prints matching lines. In this activity, `grep "ERROR" sys_events.log` lists error records, while `grep -E "root|user01" sys_events.log` uses extended regular expressions to match lines containing either `root` or `user01`.

## `chown`

`chown` changes the owner and optionally the group associated with a file or directory. In this activity, `sudo chown root:root confidential.txt` changes both the file owner and group to `root`; administrator privileges are needed for this change.

## `usermod`

`usermod` modifies an existing user account. The `-aG` options append a user to supplementary group membership without replacing existing supplementary groups, so `sudo usermod -aG sudo guest1` adds `guest1` to the `sudo` group.

## Observation after changing `confidential.txt` ownership

The file is first assigned mode `600`, which grants read/write access only to its owner. After ownership changes to `root`, the ordinary `forensic01` account is no longer the owner and has no group/other permissions, so attempts to read or append to the file should fail with “Permission denied.” This demonstrates how ownership and permission bits work together to restrict access. A user with authorized `sudo` privileges may still be able to access the file through privileged commands.
