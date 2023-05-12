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
