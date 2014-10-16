module Travis
  module Build
    class Script
      class Ruby < Script
        DEFAULTS = {
          rvm:     'default',
          gemfile: 'Gemfile'
        }

        include Jdk
        include RVM
        include Bundler

        def announce_system_info
          commands = [
            'rvm list'
          ]
          super(commands)
        end

        def announce
          super
          cmd 'gem --version', timing: false
        end

        def script
          gemfile? then: 'bundle exec rake', else: 'rake'
        end

        private

        def uses_java?
          uses_jdk?
        end
      end
    end
  end
end
