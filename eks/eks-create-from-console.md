# EKS-creation from console

```
aws iam list-instance-profiles-for-role --role-name abc-iam-role

aws iam remove-role-from-instance-profile --instance-profile-name abc-profile --role-name abc-iam-role

aws cloudformation update-termination-protection \
  --stack-name eksctl-my-eks-nodegroup-node2 \
  --no-enable-termination-protection \
  --region ap-south-1

```
