# Import commands
```
terraform import module.instance1.google_compute_instance.instance $PROJECT_ID/$ZONE/tf-instance-1
terraform import module.instance2.google_compute_instance.instance $PROJECT_ID/$ZONE/tf-instance-2
```

# Create directories
```
touch main.tf
touch variables.tf
mkdir modules
mkdir modules/instances
touch modules/instances/instances.tf
touch modules/instances/variables.tf
touch modules/instances/outputs.tf
mkdir modules/storage
touch modules/storage/storage.tf
touch modules/storage/variables.tf
```

# Taint command
```
terraform taint module.instances.google_compute_instance.instance3
