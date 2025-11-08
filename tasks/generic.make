OOPR = ../output ../temp ../report ../input $(if $(shell command -v sbatch),run.sbatch) #Order-only pre-reqs
JULIA_OOPR = $(OOPR) ../input/Manifest.toml ../input/Project.toml
STATA_OOPR = $(OOPR) profile.do

slurmlogs ../input ../output ../temp ../report:
	mkdir $@

run.sbatch: ../../setup_environment/code/run.sbatch | slurmlogs
	ln -sf $< $@
../input/Project.toml: ../../setup_environment/output/Project.toml | ../input/Manifest.toml ../input
	ln -sf $< $@
../input/Manifest.toml: ../../setup_environment/output/Manifest.toml | ../input
	ln -sf $< $@

.PRECIOUS: ../../%
../../%: #Generic recipe to produce outputs from upstream tasks
	$(MAKE) -C $(subst output/,code/,$(dir $@)) ../output/$(notdir $@)
