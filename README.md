# Automated inspection and compliance checking
This repository hold the relevant files for corresponding publication LINK

Due to file size issues it has been chosen not to share the PCD-files, but only the analysis results from the preprocessing scrips that are shared. Additionally both the knowledge- and rule-base has been share which enable the comunity to extend, test, and validate the provided results.

## Usage of content

### Prerequisites
In order to use the prolog files one would need to download and install swi-prolog. On the linked webpage istallation guides are available. 
Additionally it is necesarry to install python and the reuired packages listed in the requirement file. 

### Running the python code
After installing the required packages one would be able to use the jupyter notebooks provided. There is one for the predefined scenarios in the root of the python folder. furthermore there is one for the in_building scenarios which is build to traverse the individual scenarios. 

### Running the prolog
As a part of this project we have provided a Makefile, which encapsulates the commands for running different instances. 

```console
make base
```

```console
make in_building_1
```
```console
make in_building_[1-6]
```

```console
make feasibility_iterative
```

### interesting queries in prolog

