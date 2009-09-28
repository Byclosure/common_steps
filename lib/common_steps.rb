require File.expand_path(File.dirname(__FILE__) + "/common_steps/helpers")
step_mother = $step_mother || Cucumber::Cli::Main.step_mother
step_mother.load_code_files(Dir[File.expand_path(File.dirname(__FILE__) + "/common_steps/step_definitions/**/*.*")])