module RGitFlow
  class Config
    class << self
      attr_accessor :options
    end

    CONFIG_DIR = Pathname.pwd

    CONFIG_FILE = File.expand_path(CONFIG_DIR, '.rgitflow')

    DEFAULT_OPTIONS = {
        :master => 'master',
        :develop => 'develop',
        :feature => 'feature/%s',
        :hotfix => 'hotfix/%s',
        :release => 'release/%s'
    }

    def self.load
      self.options = SymbolHash.new false
      options.update DEFAULT_OPTIONS
      options.update read_config_file
    end

    def self.save
      require 'yaml'
      Dir.mkdir(CONFIG_DIR) unless File.directory?(CONFIG_DIR)
      File.open(CONFIG_FILE, 'w') {|f| f.write(YAML.dump(options)) }
    end

    def self.read_config_file
      if File.file?(CONFIG_FILE)
        require 'yaml'
        YAML.load_file(CONFIG_FILE)
      else
        {}
      end
    end
  end

  Config.options = Config::DEFAULT_OPTIONS
end