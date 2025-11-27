🌟 Day-1 Topics (Shell Scripting)

What you will learn today:

Topic	Coverage
1. Basics & Execution	Shebang, execution, shell types
2. Variables	System, environment, user variables
3. Conditional Statements	if/else, nested if, case
4. Loops	for, while, until, break/continue
5. Functions	return values, arguments
6. Arrays	indexed & associative
7. Input-output	read, echo, redirection
8. Exit status & debugging	set -x, $?
9. Real-time DevOps Use Cases	CI/CD, Kubernetes, AWS, logs

✨ 1. Shell Script Basics
Shebang
#!/bin/bash

How to run
chmod +x demo.sh
./demo.sh

✨ 2. Variables
#!/bin/bash
name="Thiru"
echo "Hello $name"

Environment variables
echo $PATH
export PROJECT=devops

✨ 3. Conditions (If-Else)
#!/bin/bash
num=10

if [ $num -gt 5 ]; then
  echo "Number is greater than 5"
else
  echo "Number is less or equal"
fi

Real Example – Check if service is running
#!/bin/bash
service="docker"

if systemctl is-active --quiet $service; then
  echo "$service running"
else
  echo "$service stopped"
fi

✨ 4. Loops
For Loop
for i in {1..5}; do
  echo "Iteration: $i"
done

While Loop
count=1
while [ $count -le 5 ]; do
  echo "Count: $count"
  ((count++))
done

Loop through files
for file in *.log; do
  echo "File: $file"
done

✨ 5. Functions
myFunc() {
  echo "Running Function"
}
myFunc

Function with arguments
add() {
  echo "Sum: $(($1 + $2))"
}

add 50 60

✨ 6. Arrays
arr=("devops" "aws" "docker" "k8s")
echo ${arr[1]}         # aws
echo ${arr[@]}         # print all
echo ${#arr[@]}        # length

✨ 7. Read User Input
echo "Enter your name:"
read name
echo "Welcome $name"

✨ 8. Exit Status & Debugging
command
echo $?

set -x   # enable debugging
set +x   # disable

🚀 REAL DEVOPS PRACTICAL INTERVIEW SCENARIOS
📝 Scenario 1: Create a script to start or stop a service
#!/bin/bash

action=$1
service="docker"

case $action in
  start) systemctl start $service ;;
  stop)  systemctl stop $service ;;
  status) systemctl status $service ;;
  *) echo "Usage: $0 {start|stop|status}" ;;
esac

Run:
./svc.sh start

📦 Scenario 2: Check disk space and send alert
#!/bin/bash
usage=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')

if [ $usage -gt 80 ]; then
  echo "Disk is Critical: $usage%" | mail -s "Disk Alert" admin@example.com
fi

🐳 Scenario 3: List all Docker containers
#!/bin/bash
for container in $(docker ps -q); do
  echo "Running container: $container"
done

☸️ Scenario 4: Restart all pods in a namespace
#!/bin/bash
namespace="dev"

for pod in $(kubectl get pods -n $namespace -o jsonpath='{.items[*].metadata.name}'); do
  kubectl delete pod $pod -n $namespace
done

🎯 Senior DevOps Interview Questions – Shell Scripting
Question	Expected Answer Direction
How do you debug a shell script?	set -x, set -e, trap
What is the difference between sh, bash, zsh?	features, speed, compatibility
How do you pass arguments to a script?	$1, $2, $@, $*
What is the use of trap?	cleanup, signals handling
What is exit status?	$?
🧪 Mini Assignment for Today
1️⃣ Write a script to backup /var/log to /tmp/logs-<date>.tar.gz
2️⃣ Script to validate if a file exists, readable & writable
3️⃣ Script to parse logs for error count
🎉 Day-1 Summary

✔ Basic scripting foundation
✔ Real-time tasks used in interviews + production
✔ Practical examples & assignments

📅 Day-2 Preview (Tomorrow)

🔹 Advanced Shell – trap, sed, awk, crontab, regex
🔹 Interview tasks & Use cases