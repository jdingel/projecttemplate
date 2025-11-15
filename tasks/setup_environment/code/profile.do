version 18

// If we are not in setup_environment:
if strpos(c(pwd),"setup_environment")==0 {
    // First verify that adofile directory exists
    capture confirm file ../../setup_environment/code/Stata_adofiles/
    // If it does not exist, throw error message
    if _rc != 0 {
        display as error ///
        "ERROR: Please set up ../../setup_environment/code/Stata_adofiles/. " ///
        "Because this error is reported within profile.do, the rest of the Stata script will nonetheless run. " ///
        "The shell_function catcher should flag an error after the script finishes."
        confirm file ../../setup_environment/code/Stata_adofiles/
    }
    // Otherwise, set Stata_adofiles to beginning of Stata's adofile search path
    adopath ++ "../../setup_environment/code/Stata_adofiles"
    // Verify that stata package requirements file exists
    confirm file ../../setup_environment/output/stata_requirements.txt
    // Enforce package version requirements
    require using "../../setup_environment/output/stata_requirements.txt"
}
