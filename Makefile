.PHONY: base
base:
	@echo 'Example usage: check_planned_scen(File_id,File_name,Actual_Class_name,Predicted_Class_name,TPos,FNeg,FPos, Fit).'
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl prolog/knowledge.pl 

.PHONY: feasibility_iterative
feasibility_iterative:
	@echo 'Example usage: findall(Iteration, file_iteration_mapping(Iteration, _),Its),sort(Its,Its_S), findall((It,N,Time),(member(It,Its_S), time_iteration(It,Time,N)),LO), writefacts(LO).'
	swipl prolog/classes.pl prolog/rule_base.pl prolog/knowledge_feasability_2.pl 

.PHONY: in_building_1
in_building_1:
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl python/in_building/1/knowledge.pl

.PHONY: in_building_2
in_building_2:
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl python/in_building/2/knowledge.pl

.PHONY: in_building_3
in_building_3:
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl python/in_building/3/knowledge.pl

.PHONY: in_building_4
in_building_4:
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl python/in_building/4/knowledge.pl

.PHONY: in_building_6
in_building_6:
	@echo 'Example usage: classify_file(File_id, File_name, Class_id, Class_name, Fit).'
	swipl prolog/classes.pl prolog/rule_base.pl python/in_building/6/knowledge.pl

