# DevOpsFetch

The `DevOpsFetch` command line tool is designed to help DevOps professionals gather and display critical system information. Below is an explanation of how to use this tool and what each option does.

## Description

The devopsfetch tool collects and displays various system information to assist in DevOps tasks, such as monitoring active ports, Docker containers, Nginx configurations, and user login activities. It also allows for displaying system activities within a specified time range.

## Options
-p, --port [PORT]: Display active ports or detailed information about a specific port.

-d, --docker [NAME]: List Docker images and containers, or provide details about a specific container.

-n, --nginx [DOMAIN]: Show Nginx domains and their ports, or the configuration for a specific domain.

-u, --users [USER]: List users and their last login times, or details about a specific user.

-t, --time START END: Display system activities within a specified time range.

-h, --help: Display the help message with usage instructions and options.

## Detailed Explanation of Options
-p, --port [PORT]
Displays information about active ports. Without an argument, it lists all active ports, the users owning them, and the associated services and processes. With a specific port number as an argument, it provides detailed information for that port.

-d, --docker [NAME]
Lists Docker images and containers. Without an argument, it displays all Docker images and containers. With a specific container name as an argument, it provides detailed information about that container, such as its state, IP address, and ports.

-n, --nginx [DOMAIN]
Shows Nginx domains and their listening ports. Without an argument, it lists all Nginx domains and the ports they listen on. With a specific domain as an argument, it provides the Nginx configuration for that domain.

-u, --users [USER]
Lists users and their last login times. Without an argument, it displays all users and their last login times. With a specific username as an argument, it provides detailed information about that user, including their ID, last login, and groups they belong to.

-t, --time START END
Displays system activities within a specified time range. The start and end times should be provided in a recognizable date format. If only a start time is provided, activities for that day are shown. If both start and end times are provided, activities between those times are displayed.

-h, --help
Displays a help message that includes usage instructions and a description of each option.

Let's install;

## Installation

1. Clone this repository using this command below and cd into the directory:

```console
   git clone https://github.com/yourusername/devopsfetch.git
   cd devopsfetch
```
2. Next, run the installation script with the command below:

    ```console
    sudo bash install.sh
    ``````
This command goes ahead to update the system package list and also install all the necessary dependencies, set up the DevOpsFetch script, and thus create a systemd service for monitoring.

The necessary dependencies are: 
   
   - nginx
   - docker.io
   - jq (for JSON parsing)
  

Now, in order to use, the options above come into play;

Examples command:

1. Display all active ports:

```console
devopsfetch -p
```

2. Display Nginx configuration for an exact domain:
```console
devopsfetch -n domain.com
```

3. Display an exact port:

```console
devopsfetch -p 80
```

4. 
Display user information:

```console
devopsfetch -u ubuntu
```

5. DevOpsFetch logs all activities to /var/log/devopsfetch.log.

To view the logs, use this command:

```console
sudo tail -f /var/log/devopsfetch.log
```

6. Display activities on an exact date:
```console
devopsfetch -t "2024-07-18"
```
