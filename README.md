# IP_Resolver

A Bash script for resolving IP addresses from target names.


## Description

This Bash script allows you to resolve IP addresses from target names. You can provide a list of target names in a file or specify a single target name as an argument. The script will then resolve the IP addresses and output the results to a file or stdout.

**Installation**
```
1. git clone https://github.com/RajQureshi/IP_Resolver.git
2. cd ipresover
4. ./ipresover.sh
```
**Usage**
1. To resolve the IP address of a single target name:
   ```
   ./ipresover.sh -u example.com -o output.txt
3. To resolve IP addresses from a list of target names in a file:
   ```
   ./ipresover.sh -l target_list.txt -o output.txt
## Options
    -l, --list <list_file>: Provide a list of target names (one per line) in a file.
    -u, --url <target_name>: Provide a single target name as an argument.
    -o, --output <output_file>: Specify the output file (default: stdout).
    -h, --help: Display the help message.

## License

This project is licensed under the MIT License - see the LICENSE file for details.


