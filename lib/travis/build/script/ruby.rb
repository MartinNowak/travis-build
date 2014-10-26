module Travis
  module Build
    class Script
      class Ruby < Script
        DEFAULTS = {
          rvm:     'default',
          gemfile: 'Gemfile'
        }

        include Bundler, RVM, Jdk

        def announce
          super
          sh.cmd 'gem --version', timing: false
        end

        def script
          sh.if "-f #{config[:gemfile]}" do
            sh.cmd 'bundle exec rake'
          end
          sh.else do
            sh.cmd 'rake'
          end
        end

        private

          def uses_java?
            uses_jdk?
          end
      end
    end
  end
end
