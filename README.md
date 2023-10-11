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
The make base command will load the rule base and the predefined scenarios. It will also print two example commands that can be used to classify all the scenarios, and classify and ontly provide those that was not correctly classified. 

```console
make in_building_1
```

```console
make in_building_[1-6]
```
The make in_building_1 - 6 command will allow the user to load the rule base and the knowledge vile fomr the respective folder. Notice that some of the foldes contain more than one instance. The make command also prints an example usage to classify the instances in the respective folder. 


```console
make feasibility_iterative
```
The feasibility study knowledge base violated the file size rule of github, and had to be compressed. This means that the zipped file has to be unsipped before this command can be used. When the command is used the rule base and feasibility study knowledge base will be loaded, and the example usage will be printed in the console. The study will take some time to run, as it will complete the full size study that was performed in the paper.


