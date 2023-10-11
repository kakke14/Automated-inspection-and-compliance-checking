# Automated inspection and compliance checking
This repository hold the relevant files for corresponding [Publication](https://link-url-here.org)

Due to file size issues it has been chosen not to share the PCD-files, but only the analysis results from the preprocessing scrips that are shared. Additionally both the knowledge- and rule-base has been share which enable the comunity to extend, test, and validate the provided results.

## Usage of content

### Prerequisites
In order to use the prolog files one would need to download and install [SWI-prolog](https://www.swi-prolog.org). On the linked webpage istallation guides are available. 
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


### Example queries
This section shows how different queries can be performed and thier output. The example are showing different combinations and abstractions

Initiate this with with the predefined scenarios (also works for the others)
```console
make base
```
If we wanted to see what files we have available we could run the following query and then use space to get the next solution. 
```console
?- file_record(File_name, File_id).

File_name = "../Scaled/scen1.pcd",
File_id = 0 ;
File_name = "../Scaled/scen2.pcd",
File_id = 1;
...
File_name = "../Scaled/scen22.pcd",
File_id = 21.
```
In the case that we wanted a [set of](https://www.swi-prolog.org/pldoc/doc_for?object=setof/3) all the File_ids we could run the following query, which is finding all the file_records-predicates and add the File_id to the SetOfFileIDs. A caviat is that we have to tell prolog that the File_name variable is allowed to change, which is done with the "File_name^"
```console
?- setof(File_id, File_name^file_record(File_name, File_id), SetOfFileIDs).

SetOfFileIDs = [0, 1, 2, 3, 4, 5, 6, 7, 8|...].
```
The above can also be performed with the [findall](https://www.swi-prolog.org/pldoc/doc_for?object=findall/3) function, which will automatically make different combinations of the File_name

```console
?- findall(File_id, file_record(File_name, File_id), SetOfFileIDs).

SetOfFileIDs = [0, 1, 2, 3, 4, 5, 6, 7, 8|...].
```
There are also other approaches [all solutions](https://www.swi-prolog.org/pldoc/man?section=allsolutions) to a Goal



#### Find all files that contains the toe_board_missing violation?
If we want to find all files that violates the regulation of having a toeboard, we would ask Prolog to find thos with the following query

```console
?- findall(File_id, violation(toe_board_missing, File_id), SetOfFileIDs).

SetOfFileIDs = [1, 12, 13, 20].
```
#### What violations were found for a specific file?
Similar to the previos list cretion, we could ask for all the violations that are identified in a file
```console
?- File_id = 12, findall(Violations, violation(Violations, File_id), SetOfViolations).

File_id = 12,
SetOfViolations = [toe_board_missing, middle_pole_missing].
```
#### Exactly which board is the top board for a particular file?
Based on the previos query we can also see that File_id 12 does not violate the top_board_missing, which means that it must have a top board. Let's get the id of the board
```console
?- File_id=12, top_board(File_id,Board_id)
File_id = 12,
Board_id = 87
```
#### What does the geometry of a particular bord look like?
Knowing the actual id of the board we can also investigate the detailed record, which will be based on the object-fact from the knowledge base
```console
?- File_id=12, Object_id=87, object(File_id, Object_id, Type, Geometry).

File_id = 12,
Object_id = 87,
Type = board,
Geometry = seg(1, 120, 433, 123).
```
### Comapred to all the predefined classes, which is more similar to a particular file?
After studying File_id 12 what class does it actually belong to? we can figure this out with the classify-predicate as shown below.
```console
?- File_id=12, classify_file(File_id, File_name, Class_id, Class_name, Fit).

File_id = Class_id, Class_id = 12,
File_name = "../Scaled/scen13.pcd",
Class_name = "Combination 1",
Fit = 0 ;
```
### Sum up
The provided example briefly shows how different queries can be tweaked to return different information about the knowledge base. Please have a look in the rule_base.pl file for additional ideas of queries that might be interesting.
