actions :run
default_action :run

attribute 	:source, :kind_of => Hash, :required => true
attribute	:dest, :kind_of => Hash, :required => true
attribute	:parameters, :kind_of => Hash, :default => {}