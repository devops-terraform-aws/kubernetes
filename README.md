# EC2 instance creation using Python and boto3 library
This script allows the user to create an EC2 instance in a specified region using the latest Ubuntu 20.04 LTS AMI. The script uses the `boto3` library to interact with AWS services.

## Prerequisites
- AWS account with permissions to create EC2 instances
- Access key and secret key for the above AWS account
- `boto3` library installed in the Python environment
- A key pair created in the specified region, to allow logging into the EC2 instance.

### To Run in `Browser Mode`
1. Set alias of `python3` to `python`
    ```
    sudo ln -sf $(which python3) /usr/bin/python
    ```

2.  Set virtual evironment:
    ```
    python -m venv venv
    ```
    ```
    source venv/bin/activate
    ```

3. Install required application 
    ```
    pip install Flask
    ```
    ```
    python -m flask --version
    ```
    ```
    pip install boto3
    ```

4. To run application, make sure you are still on the virtual environment `venv`
    - To create EC2
        ```
        python create_dashboard.py
        ```
    - To destroy EC2
        ```
        python destroy_dashboard.py
        ```

5. Go to the brower and run
    ```
    localhost:5000
    ```

### To Run on `CLI` or `Locally`
1. Run the command:
    ```
    python create_ec2.py
    ```

## Usage
1. The script prompts the user to enter the region they want to create the EC2 instance in (e.g. us-east-1)
2. The script uses the `describe_images` method of the EC2 client to get the latest Ubuntu 20.04 LTS AMI
3. The script then uses the `run_instances` method of the EC2 client to create the EC2 instance, using the specified AMI, instance type, key pair, and security group.
4. The script also attaches a name tag to the instance, for easier identification
5. The script prints the ID of the newly created instance

## Additional notes
- The script uses the owner ID `099720109477`, which belongs to Canonical (the company behind Ubuntu). This is to ensure that only official Ubuntu AMIs are considered
- The script sorts the list of AMIs by the `CreationDate` attribute, in descending order, to ensure that the latest AMI is selected
- The script catches the `IndexError` that is raised when no images are found that match the specified filters and shows the respective message
- The script uses the following paramters for run_instances:
    - `ImageId`: the latest AMI id
    - `InstanceType`: the type of instance to be created. (t2.micro)
    - `MinCount`: minimum number of instances to be created
    - `MaxCount`: maximum number of instances to be created
    - `KeyName`: name of the key pair to be used
    - `SecurityGroups`: name of the security group to be used
    - `TagSpecifications`: add tags to the instance for easy identification.

## Conclusion
This script provides an easy way to spin up an EC2 instance in a specified region, using the latest Ubuntu 20.04 LTS AMI. It can be further modified and integrated into other scripts or automation processes.

# Kubernetes

https://kubernetes.io/docs/concepts/overview/components/

`Node`: A Virtual machine

`Master Node`: Control plane

### Control Plane
- API server 

    Authentication checks for request that comes to it. Sits on the control plane and it is being used pass messages to services. Has permission to interact with etcd(database)

    - `Horizontal Scaling`: Create multiple instances of the same thing and load balancing among them. e.g.- Zero downtime. 
                          If there is no traffic, we can delete other instances (the instances are not in sync)
                          HPA - Horizontal Pod Autoscaling: If CPU goes above or below scale it down or up.
    - `Vertically Scaling`: Spin up a big instance as compared to the previous machine. 
                          Stop traffic in previous and move traffic to big instance. There is some downtime.

- etcd

    Like a Database which store information about entire cluster. Example if we have 3 containers (node 1, node 2, node 3) it stores information in key value pairs.

- kuber-schedulers 

    Check on which node to place a container based on request from the requirements on etcd

- kube-controller-manager

    A big umbrella where we have a node controller, job controller, service account controller 
    
    - `Node controller`: Check for the nodes. If node stops responding
    - `Job controller`: Watches for job objects that represents one-off tasks, then creates Pods to run those task to completion
    - `ServiceAccount controller`: Creates default ServiceAccounts for new namespaces
    - `EndpointSlice controller`: provide a link between Services and Pods

- Cloud Control Manager:

    Only open to all cloud providers. Not available on prem

### Worker Node: 
  - `Container Runtime`: Involvement for the containers to run
  - `Kubelet`: Running the pod on the specific node. Scheduler passes information to kubelet and kubelet is doing the deployment on the pod machine.
  - `Kubeproxy`: used for maintaining network policy. If you want network to communicate and not communicate with each other (Setting up network policies)
