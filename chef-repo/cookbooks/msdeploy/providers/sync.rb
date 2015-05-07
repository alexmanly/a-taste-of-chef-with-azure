include Chef::Mixin::ShellOut

def whyrun_supported?
	true
end

action :run do
	converge_by("Sync #{@new_resource.name}") do		
		source = @new_resource.source.entries[0]
		source = alias_provider(*source)
		source = download_source_package(*source)
		
		dest = @new_resource.dest.entries[0]
		dest = alias_provider(*dest)
	
		args = [
			{:verb => 'sync'},
			{:source => build_provider_arg(source)},
			{:dest => build_provider_arg(dest)}
		]
		
		@new_resource.parameters.each do |k, v|
			args << {:setParam => %Q("#{k}"="#{v}") }
		end
		
		run_msdeploy args		
	end
end

private
def build_provider_arg(provider)
	"#{provider[0]}=#{provider[1]}"
end

def alias_provider(provider, providerPath)
	if provider == :path
		provider = :contentPath
	end
	
	[provider, providerPath]
end

def download_source_package(provider, providerPath)
	if provider == :package then
		file_name = ::File.basename(providerPath)
		local_file = "#{Chef::Config[:file_cache_path]}/#{file_name}"
		
		remote_file local_file do
			action :nothing
			source new_resource.source[:package]
		end.run_action(:create)
		
		providerPath = local_file
	end
	
	
	return [provider, providerPath]
end


def run_msdeploy(args)
	cmd = '"' + get_msdeploy_path + '" '
	
	args.each do |param|		
		key = param.entries[0][0].to_s
		value = param.entries[0][1].to_s
		
		cmd += "-#{key}:#{value} "
	end
	
	Chef::Log.info("RUN: #{cmd}")
	
	shell_out!(cmd)
end

def get_msdeploy_path
	::Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\\Microsoft\\IIS Extensions\\MSDeploy\\3') do |reg|		
		return "#{reg['InstallPath']}\\msdeploy.exe"
	end
end