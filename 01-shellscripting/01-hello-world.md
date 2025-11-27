# DevOps Senior Engineer Prep – Day 1 (Shell Scripting)

## 📌 Topics for Day 1

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
---

## 3️⃣ Conditions (if / else / case)

```bash
num=10
if [ $num -gt 5 ]; then
  echo "Greater than 5"
else
  echo "Less or Equal"
fi
```

### Real Example – Check if Service Running

```bash
service="docker"
if systemctl is-active --quiet $service; then
  echo "$service running"
else
  echo "$service stopped"
fi
```

### Case Example

```bash
action=$1
case $action in
  start) echo "Starting" ;;
  stop) echo "Stopping" ;;
  *) echo "Usage: $0 {start|stop}" ;;
esac
```

---

## 4️⃣ Loops

### **For Loop**

```bash
for i in {1..5}; do
  echo "Iteration $i"
done
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
