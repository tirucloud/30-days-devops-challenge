# Day 1 - Shell Scripting
- It allows users to enter commands to perform actions such as file management, system control, and running applications.
- It serves as both a user interface and a scripting environment used to automate tasks.
- The shell acts as an interpreter, translating user commands into instructions that the operating system can execute.
## 📌 Topics:

| Topic                 | Coverage                          |
| --------------------- | --------------------------------- |
| 1. Basics & Execution | Shebang, execution, shell types   |
| 2. Variables          | System, environment, user         |
| 3. Conditions         | if/else, nested if, case          |
| 4. Loops              | for, while, until, break/continue |
| 5. Functions          | arguments, return values          |
| 6. Arrays             | indexed & associative             |
| 7. I/O                | read, echo, redirection           |
| 8. Debugging          | set -x, exit status               |
| 9. DevOps Scenarios   | Docker, Kubernetes, alerts        |

---

## 1️⃣ Shell Script Basics
```
# Shebang
# Run Script / Execute Shell Scripts
# Method 1: Make script executable and run
chmod +x script.sh
./script.sh
# Method 2: Run without changing permissions
bash script.sh
sh script.sh
# Method 3: Run with full path
/bin/bash /path/to/script.sh
```
### **create a demo.sh file**
```bash
#!/bin/bash
echo "Welcome to shell!"
```

### **Run Script**

```bash
chmod +x demo.sh
./demo.sh
```

---

## 2️⃣ Variables

```bash
#!/bin/bash

echo "Hello, what is your name?"
read name

echo "Nice to meet you, $name"

```

### Environment Variables

```bash
echo $PATH
export PROJECT=devops
```

```
echo $PROJECT
# Make it available to other shells

Add to .bashrc or .profile

echo 'export PROJECT=devops' >> ~/.bashrc
source ~/.bashrc
```
```
export VERSION=1.0.5
docker build -t myapp:$VERSION .
```
## 📌 Environment variables to:
- Control application configuration
- Version Docker images
- Automate deployment
- Avoid hardcoding values

```bash
#!/bin/bash

# Environment variables
export APP_NAME="payment-service"
export VERSION="v1.2.0"
export AWS_ACCOUNT_ID="123456789012"
export REGION="us-east-1"
export ECR_REPO="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$APP_NAME"

echo "----- Starting Deployment -----"
echo "App Name : $APP_NAME"
echo "Version  : $VERSION"
echo "ECR Repo : $ECR_REPO"

# Build Docker image
docker build -t $APP_NAME:$VERSION .

# Tag image
docker tag $APP_NAME:$VERSION $ECR_REPO:$VERSION

# Push to AWS ECR
docker push $ECR_REPO:$VERSION

# Update Kubernetes deployment
kubectl set image deployment/$APP_NAME $APP_NAME=$ECR_REPO:$VERSION

echo "Deployment completed successfully!"
```
```
# Check the update status
kubectl rollout status deployment/$APP_NAME

# Undo if required
kubectl rollout undo deployment/$APP_NAME
```
---

## 3️⃣ Conditions (if / else / case)
### Check if Service Running

```bash
service="docker"
if systemctl is-active --quiet $service; then
  echo "$service running"
else
  echo "$service stopped"
fi
```
### Check running status of pods 
```bash
#!/bin/bash

APP_NAME="webapp"
NAMESPACE="default"

echo "Checking pod status for application: $APP_NAME ..."

# Get pod status
pod_status=$(kubectl get pods -n $NAMESPACE | grep $APP_NAME | awk '{print $3}')
not_running=false

for status in $pod_status
do
  if [ "$status" != "Running" ]; then
    not_running=true
    echo "❌ Pod is NOT running. Status: $status"
  fi
done

if [ "$not_running" = true ]; then
  echo "⚠️ One or more pods are in a failed state!"

  # Example alert (email or Slack notification)
  echo "Sending alert to DevOps Team..."
  # curl -X POST -H 'Content-type: application/json' --data '{"text":"Pods failing for service '$APP_NAME'!"}' https://hooks.slack.com/services/xxxxx/yyyyy/zzzzz

  exit 1
else
  echo "✅ All pods are running normally."
fi

```


## Case Example

```bash
action=$1
case $action in
  start) echo "Starting" ;;
  stop) echo "Stopping" ;;
  *) echo "Usage: $0 {start|stop}" ;;
esac
```
## if-else-case
```
#!/bin/bash
# Script Name: service-check.sh

SERVICE="docker"

echo "Checking status of $SERVICE service..."

# Check if service exists & determine running status
if systemctl list-unit-files | grep -q "^$SERVICE.service"; then

    # Get service status (active/inactive/failed)
    status=$(systemctl is-active $SERVICE)

    if [ "$status" = "active" ]; then
        echo "✅ $SERVICE service is currently RUNNING."
    else
        echo "⚠️  $SERVICE service is NOT running. Current status: $status"

        # Let user choose next action
        echo -e "\nSelect an action:"
        echo "1) Start service"
        echo "2) Check logs"
        echo "3) Exit"

        read -p "Enter choice (1/2/3): " choice

        case $choice in
            1)
              echo "Starting $SERVICE service..."
              sudo systemctl start $SERVICE
              echo "Service started."
              ;;
            2)
              echo "Showing last 20 log lines..."
              sudo journalctl -u $SERVICE -n 20
              ;;
            3)
              echo "Exiting script."
              exit 0
              ;;
            *)
              echo "❌ Invalid option. Exiting."
              exit 1
              ;;
        esac
    fi

else
    echo "❌ Service $SERVICE does not exist on this system."
    exit 1
fi
```
---

## 4️⃣ Loops

### **For Loop**

```bash
for i in {1..5}; do
  echo "Iteration $i"
done
```
```
#!/bin/bash

NAMESPACE="production"
APP="payments"

echo "Checking restart count of $APP pods in namespace $NAMESPACE"

# Get list of pod names
pods=$(kubectl get pods -n $NAMESPACE -o jsonpath="{.items[*].metadata.name}" | tr ' ' '\n' | grep $APP)

for pod in $pods
do
    # Get restart count for each pod
    restart_count=$(kubectl get pod $pod -n $NAMESPACE -o jsonpath="{.status.containerStatuses[0].restartCount}")

    echo "Pod: $pod | Restart Count: $restart_count"

    if [ $restart_count -gt 3 ]; then
        echo "⚠️  Pod $pod is restarting frequently. Taking corrective action..."
        
        # Restart the specific pod (delete, so deployment recreates it)
        kubectl delete pod $pod -n $NAMESPACE

        echo "🔁 Restart triggered for $pod"
    else
        echo "✔️  Pod $pod is healthy"
    fi

    echo "---------------------------------------------"
done

echo "Health check completed."
```


### **While Loop**

```bash
count=1
while [ $count -le 5 ]; do
  echo "Count: $count"
  ((count++))
done
```

### Loop over Files

```bash
for file in *.log; do
  echo "File: $file"
done
```

---

## 5️⃣ Functions

```bash
myFunc() {
  echo "Running Function"
}
myFunc
```

### With Arguments

```bash
add() {
  echo "Sum: $(($1 + $2))"
}
add 50 60
```

---

## 6️⃣ Arrays

```bash
arr=("devops" "aws" "docker" "k8s")
echo ${arr[1]}
echo ${arr[@]}
echo ${#arr[@]}
```

---

## 7️⃣ User Input

```bash
echo "Enter name:"
read name
echo "Welcome $name"
```

---

## 8️⃣ Exit Status & Debugging

```bash
command
echo $?
```

```bash
set -x
set +x
```

---

## 🚀 Practical DevOps Interview Scenarios

### Scenario 1 – Manage Service Status

```bash
#!/bin/bash
action=$1
service="docker"
case $action in
 start) systemctl start $service ;;
 stop) systemctl stop $service ;;
 status) systemctl status $service ;;
 *) echo "Usage: $0 {start|stop|status}" ;;
esac
```

---

### Scenario 2 – Disk Alert Script

```bash
usage=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')
if [ $usage -gt 80 ]; then
  echo "Disk Critical: $usage%" | mail -s "Disk Alert" admin@example.com
fi
```

---

### Scenario 3 – List Docker Containers

```bash
for container in $(docker ps -q); do
  echo "Running container: $container"
done
```

---

### Scenario 4 – Restart Kubernetes Pods

```bash
namespace="dev"
for pod in $(kubectl get pods -n $namespace -o jsonpath='{.items[*].metadata.name}'); do
  kubectl delete pod $pod -n $namespace
done
```

---

## 🎯 Interview Questions

| Question                        | Expected Answer                 |
| ------------------------------- | ------------------------------- |
| How do you debug shell scripts? | set -x, set -e, trap            |
| How to pass arguments?          | $1, $2, $#, $@, $*              |
| Difference b/w sh & bash?       | Feature support & compatibility |
| What is exit code?              | $?                              |
| What is trap used for?          | Signal handling & cleanup       |

---

## 🧪 Assignments

1. Backup `/var/log` to `/tmp/logs-<date>.tar.gz`
2. Validate file exists and permissions
3. Script to parse log and count errors

---

## 📅 Day-2 Preview

🔹 Advanced Shell: sed, awk, cut, grep, crontab, regex, trap

---
