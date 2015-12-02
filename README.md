## Introduction
This repository contains the files related to the deployment of MariaDB cluster on Microsoft Azure using Azure ARM templates.

## Architecture
The architecture for the MariaDB cluster consists of 3 VM, each VM running a instance of MariaDB with Gelera clustering. These VM nodes form a single active/active MySQL cluster. Each of the VM nodes is deployed in a avaialbiltiy set fault zone to ensure resielence of the cluster by allowing the failure or upgrade of a single node with out affecting the operations of the MySQL cluster operations. The VM and loadbalancer infrasstructure is deployed inside a single region and with in this region the infrastructure is deployed with in a vNET and vNET subnet, the vNET is using a fixed subnet range of 10.0.0.0/24. 
This cluster is forntended by a Azure loadbalancer to distribut the incomming requests to the MySQL nodes in the cluster. The basic architecture layout is contained in the following diagram,

![](https://raw.githubusercontent.com/keithtobin/mariadbazure/master/images/diagram01.jpg)

## Deployment
You will need access to an Azure accoun, this Azure account will be used to deploy this ARM template to. Deployment is easy, located on this page is the deploy to azure button, all you need to do is to click this button to start the deployment process. You will be taken to the new azure portal, if you are not logged in to Azure already you will have to login using you user-name and password. You will be presented with a number of textboxes, each of these text boxes related to a required ARM template parameter that is used during the deployment process. These parameters will need to be filled in and and then click the OK button at the botton of the current pane.Select or create a region for the deployment to be deployed to in the next available pane and read the T&Cs and click OK. The deployment will begin and after some time the MariaDB cluster will bedeployed.

Click the following button to start the deployment of this arm template to your Azure account.
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkeithtobin%2Fmariadbazure%2Fmaster%2Fcreate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a><a  target="_blank">

##Testing
To test if the deployment is of MariaDB has being successfull, you can SSH to the VM1 using it's public available IP, after you have sshed you can execute the following command to see the size of the cluster. 

mysql -u root -p  -e "show global status like 'wsrep_cluster_size'

## Debug

### VM Init Process
During the ARM tem