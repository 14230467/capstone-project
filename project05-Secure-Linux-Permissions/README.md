# Secure Linux Server Permissions

This project demonstrates how to implement user-based access control on a Liniux server using users, groups, file ownership, and permissions.

The objective is to ensure that only authorized users can access a protected directory while unauthorized users are denied access.

## 1. Implement users and groups

Commands:
```bash
sudo groupadd developers
sudo useradd -m -s /bin/bash A
sudo useradd -m -s /bin/bash B
sudo useradd -m -s /bin/bash C

sudo usermod -aG developers A
sudo usermod -aG developers B
```

## 2. Create a Protected Directory
Create a shared directory named /srv/teamdata.

```bash
sudo mkdir -p /srv/teamdata
sudo chown root:developers /srv/teamdata
sudo chmod 2770 /srv/teamdata
```

The direcory permissions ensure:
- Owner(root): Read, write, execute
- Group (developers): Read, write, execute
- Others: No access
- Setgid: New files inherit the directory's group

## 3. Test Allowed Access
Executed the following command as A:
```bash
sudo -u A touch /srv/teamdata/A.txt
```

Result: Successful file creation because <strong>A</strong> belongs to the developers group

## 4. Test Denied Access
Executed the following command as C:
```bash
sudo -u C touch /srv/teamdata/C.txt
```

Result: Access denied because <strong>C</strong> is not a member of the developers group