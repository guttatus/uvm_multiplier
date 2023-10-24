TOP := top_tb
FLIST := flist_sim.f
TIMESCALE := 1ns/1fs
TESTNAME := input_always_valid_test
COVNAME  := ${TESTNAME}_$(shell date '+%F_%H:%M:%S')
DUTNAME  := multiplier_inst

help:
	@echo 'build -> run -> clean'
#	@echo ${RTL_V}
#	@echo ${INCDIR}

all: clean build run cov

build:
	irun -elaborate  -l irun_elaborate.log  -noupdate \
  		 -64bit -access +rwc \
  		 -loadpli1 debpli:novas_pli_boot \
  		 -sv -nowarn NONPRT -assert \
  		 -timescale ${TIMESCALE} \
  		 -ALLOWREDEFINITION \
			 -covtest ${COVNAME} \
			 -coverage A \
			 -covdut ${TOP} \
			 -covworkdir ./cov_work\
  		 -uvm \
  		 -sv \
  		 -f ${FLIST} \
  		 -top ${TOP}

  		 # -uvmhome ${UVM_HOME} \
  		 # -uvmexthome ${CDNS_HOME}/INCISIVE/tools/methodology/UVM/CDNS-1.2 \

run:
	irun -R -64bit -loadpli1 debpli:novas_pli_boot \
			 -input irun.tcl \
  		 +UVM_TESTNAME=${TESTNAME} \
  		 -timescale ${TIMESCALE} \
		   -covoverwrite  -l irun_sim.log -nowarn VLOVAL:truncated \
			 -svseed 38 \
			 -coverage A \
			 -covtest ${COVNAME} \
			 -covdut ${TOP} \
			 -covworkdir ./cov_work



cov_merge:
	find ./cov_work/scope/ -type d  > cov_filelist
	imc -execcmd "merge -out cov_merged -runfile cov_filelist -overwrite"


imc:
	imc -gui &

nlint:
	nLint -gui -verilog -2001 -sv -beauty \
		    -detail \
		    -top ${TOP} \
		    -f ${FLIST} \
		    -out lint.log


verdi:
	verdi -sv \
		    -f ${FLIST} \
				-top ${TOP} \
				-ssf ./${TOP}.fsdb &

.PHONY: clean
clean:
	@rm -fr *~ *.bak *.log *.key  *.diag INCA_libs  *.history *.conf *.rc 


all_clean:
	@rm -fr *~ *.bak *.log *.key  *.diag INCA_libs  *.history *.conf *.rc  *.fsdb cov_filelist cov_work *.ds nLintDB nLintLog verdiLog





