module Parser
    module Yaml
        def with_yaml(file, root=nil)
            [root, ENV['ROOT'], ENV['CONFIG'], ENV['APP_HOME']].flatten.compact.each do |dir|
                f = "#{dir}/config/#{file}.yml"
                if File.exists?(f)
                    yield YAML.load_file(f)
                end
            end
        end
    end
end