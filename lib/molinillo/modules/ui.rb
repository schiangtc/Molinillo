module Molinillo
  # Conveys information about the resolution process to a user.
  module UI
    # The {IO} object that should be used to print output. `STDOUT`, by default.
    #
    # @return [IO]
    def output
      STDOUT
    end

    # Called roughly every {#progress_rate}, this method should convey progress
    # to the user.
    #
    # @return [void]
    def indicate_progress
      output.print '.' unless debug?
    end

    # How often progress progress should be conveyed to the user via
    # {#indicate_progress}, in seconds. A third of a second, by default.
    #
    # @return [Float]
    def progress_rate
      0.33
    end

    # Called before resolution begins.
    #
    # @return [void]
    def before_resolution
      output.print 'Resolving dependencies...'
    end

    # Called after resolution ends (either successfully or with an error).
    # By default, prints a newline.
    #
    # @return [void]
    def after_resolution
      output.puts
    end

    # Conveys debug information to the user.
    # By default, prints to `STDERR` instead of {#output}.
    #
    # @param [Integer] depth the current depth of the resolution process.
    # @return [void]
    def debug(depth = 0)
      if debug?
        debug_info = yield
        debug_info = debug_info.inspect unless debug_info.is_a?(String)
        STDERR.puts debug_info.split("\n").map { |s| '  ' * depth + s }
      end
    end

    # Whether or not debug messages should be printed.
    # By default, whether or not the `CP_RESOLVER` environment variable is set.
    #
    # @return [Boolean]
    def debug?
      @debug_mode ||= ENV['CP_RESOLVER']
    end
  end
end
