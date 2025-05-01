# **MyDebian**

This is my repository for my Lenovo ThinkPad T480s I use as a High school (Soon to be college) Student. I do not currently have any of my ricing (As i haven't done much yet) but if I do, I will leave any dotfiles in here. This is going to mostly have what I use at the start of my Linux (Debian 12) installation. This will include my repositories in my sources list and a general maintenance script along with more stuff as I get deeper and deeper in the Linux rabbit hole. 

## 1. MyRepoFiles.txt
- What It Is: A pre-configured list of Debian repositories tailored for Bookworm (stable) and Trixie (testing).

- Why It’s Cool: Gives you an easy-to-read and flexible /etc/apt/sources.list replacement. You can adjust your setup with a few quick edits (like uncommenting testing repos).

- How It Helps: Keeps your repositories neat and tidy, saving you from managing them manually.

## Repositories in MyRepoFiles.txt
### Main Bookworm Sources:
  - Stable release repositories for Bookworm, including main, contrib, and non-free-firmware:
`deb http://deb.debian.org/debian bookworm main contrib non-free-firmware`

### Trixie Sources (Commented):
- Testing release repositories for Trixie, which are currently disabled but available for selective use:
`deb http://deb.debian.org/debian trixie main contrib non-free-firmware`

### Bookworm Security Updates:
- Provides security patches and updates for Bookworm:
`deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware`

### Trixie Security Updates (Commented):
- Security patches for Trixie, currently commented out:
`deb http://deb.debian.org/debian-security/ trixie-security main non-free-firmware`

### Bookworm Update Sources:
- Contains stable updates for Bookworm:
`deb http://deb.debian.org/debian bookworm-updates main non-free-firmware`

### Trixie Updates (Commented):
- Testing updates for Trixie:
`deb http://deb.debian.org/debian trixie-updates main non-free-firmware`

### Why the Repos Are Set Up This Way:
- The Bookworm repositories are active by default to ensure system stability.

The Trixie repositories are commented out but can be enabled for testing or accessing newer packages by uncommenting the relevant lines.

## 2. debhealth.sh
- What It Is: A maintenance script that’s kind of your Swiss Army knife for Debian.

- Why It’s Cool: It can handle everything—from package updates and fixing dependencies to cleaning up junk and verifying your system’s health.

- How It Helps: You just run one command (debhealth) and let it do the heavy lifting

## What debhealth.sh Does
**The debhealth.sh script is a comprehensive maintenance tool designed to keep your Debian system running smoothly. Here’s a step-by-step rundown of its functionality:**

### Update Package Lists:

- Runs `sudo apt update` to fetch the latest updates for all configured repositories.

### Upgrade Installed Packages:

- Upgrades all outdated packages using `sudo apt upgrade -y`.

### Distribution Upgrades:

- Applies critical updates and kernel upgrades using `sudo apt dist-upgrade -y`.

### Clean Up Unnecessary Files:

- Removes unneeded packages and configuration files with:

  - `sudo apt autoremove --purge -y`

  - `sudo apt autoclean`

### Fix Broken Packages:

- Attempts to resolve any dependency or configuration issues with:

  - `sudo dpkg --configure -a`

  - `sudo apt install -f`

### Check System Health:

- Ensures the integrity of the APT package database using `sudo apt-get check`.

### Verify Package Integrity:

- Uses debsums (if installed) to check for corrupted or altered system files.

### Remove Orphaned Packages:

- Identifies and removes unused libraries using deborphan (if available).

### System Logs and Kernel Checks:

- Cleans journal logs and reminds you to reboot if kernel updates are applied.

### User-Friendly Reboot Option:

- At the end, it prompts you to decide whether to reboot the system.

In short, debhealth.sh keeps your system optimized, resolving common issues and ensuring your system healthy

## 3. setup.sh
- What It Is: A script that sets everything up for you. One command and boom—you’re ready to roll.

- Why It’s Cool: It handles:

  - Replacing your /etc/apt/sources.list with MyRepoFiles.txt.

  - Installing debhealth.sh in the right spot.

  - Setting up a quick alias (debhealth) so you don’t have to type long file paths.

- How It Helps: Saves time and keeps you from having to manually set everything up.

## How to Use setup.sh
### 1. Clone the Repository
Start by cloning the repository to your local machine:
`git clone https://github.com/MyNamesTJ-git/MyDebian.git`
`cd MyDebian`

### 2. Run the Setup Script
Run the setup.sh script with the following command: `sudo bash setup.sh`
***Make sure you restart your terminal after installing!!!***

### 3. What the Script Does
 When you run setup.sh, it will:

- Backup Your Current Repository List:

  - Your existing /etc/apt/sources.list will be backed up as /etc/apt/sources.list.bak.

- Replace the Repository List:

  - Installs MyRepoFiles.txt as the new /etc/apt/sources.list.

- Install and Configure debhealth.sh:

  - Copies debhealth.sh to your home directory.

  - Makes debhealth.sh executable.

  - Creates an alias, debhealth, for easy access.

- Reload Shell Configuration:

  - Updates your shell to apply the alias immediately.

### 4. Run the Maintenance Script
After running the setup script, you can use the maintenance script at any time by typing: `debhealth`

### 5. Optional: Verify the Changes
Check that the repository list was updated: `cat /etc/apt/sources.list`

Confirm that the alias is working: `debhealth`

## If your missing dependancies
- `sudo apt update`
- `sudo apt install -y debsums deborphan`
