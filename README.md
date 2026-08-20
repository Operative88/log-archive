# Log Archive Tool
[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)

A lightweight command-line tool that archives logs by compressing a target directory into a timestamped `tar.gz` file and recording each operation in a log file.

## Table of Contents
- [What It Is](#what-it-is)
- [Caveats and Limitations](#caveats-and-limitations)
- [Preview in Action](#preview-in-action)
- [Requirements](#requirements)
- [How to Install and Run](#how-to-install-and-run)
- [Project Structure](#project-structure)
- [Advanced Usage: Scheduling and Retention](#advanced-usage-scheduling-and-retention)
  - [Scheduling with cron](#scheduling-with-cron)
  - [Removing Old Archives](#removing-old-archives)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## What It Is
This repository contains a simple [Bash](https://www.gnu.org/software/bash/) script that archives logs from the command line. This project was implemented according to the [roadmap.sh Log Archive Tool project guide](https://roadmap.sh/projects/log-archive-tool).

When run against a log directory, the tool compresses its contents into a [tar.gz](https://www.gnu.org/software/tar/manual/tar.html) archive named with the current date and time (e.g. `logs_archive_20240816_100648.tar.gz`), stores it in an `archives/` subdirectory, and appends a timestamped entry to a log file for future reference. This is especially useful for clearing out old logs and keeping a system clean while preserving the logs in compressed form.

## Caveats and Limitations
- **Permissions Required:** Common log locations such as `/var/log` are owned by root, so archiving them typically requires running the tool with `sudo`.
- **Non-Destructive by Design:** The tool compresses and copies logs into an archive; it does not delete the original log files. Cleanup of the source logs is left to the user (see [Advanced Usage](#advanced-usage-scheduling-and-retention)).
- **Bash and tar Required:** The script relies on a POSIX-style shell environment with `tar` and `gzip` available.

## Preview in Action
Running the tool produces a single-line confirmation and writes the archive to disk:
```bash
$ log-archive /var/log
Archive created: /var/log/archives/logs_archive_20240816_100648.tar.gz
```

## Requirements
- A Unix-based system (Linux or macOS) with [Bash](https://www.gnu.org/software/bash/), `tar`, and `gzip` installed.

## How to Install and Run
1. **Clone the repository** and navigate to the project directory:
   ```bash
   git clone https://github.com/your-username/log-archive-tool.git
   cd log-archive-tool
   ```
2. **Make the script executable**:
   ```bash
   chmod +x log-archive.sh
   ```
3. **Run the tool** against a log directory:
   ```bash
   ./log-archive.sh /var/log
   ```
4. *(Optional)* **Install it globally** so it can be called as `log-archive` from anywhere:
   ```bash
   sudo cp log-archive.sh /usr/local/bin/log-archive
   sudo chmod +x /usr/local/bin/log-archive
   log-archive /var/log
   ```

## Project Structure
```text
.
├── log-archive.sh    # Main CLI script that compresses and logs archives
└── README.md         # Project documentation
```

## Advanced Usage: Scheduling and Retention
The tool works well as an unattended job that runs on a fixed schedule and keeps disk usage under control.

### Scheduling with cron
To archive `/var/log` automatically every day at 2:00 AM, add an entry to the crontab:
```bash
sudo crontab -e
```
Then add the following line:
```text
0 2 * * * /usr/local/bin/log-archive /var/log
```

### Removing Old Archives
To prevent archives from accumulating indefinitely, you can delete those older than 30 days:
```bash
find /var/log/archives -name "logs_archive_*.tar.gz" -mtime +30 -delete
```
This command can also be added to cron to run on its own schedule.

## Acknowledgements
- Project idea and requirements provided by [roadmap.sh DevOps Projects](https://roadmap.sh/projects/log-archive-tool).

## License
Distributed under the [MIT License](LICENSE).
