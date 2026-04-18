# frozen_string_literal: true

require_relative "history/version"

module IRB
  module FZF
    module History
      class << self
        attr_accessor :enabled

        # Enable fzf integration with IRB's reverse search
        def enable!
          return if @enabled

          @enabled = true
          @fzf_available = check_fzf_availability

          patch_reline if defined?(Reline::LineEditor)
        end

        # Disable fzf integration and restore default behavior
        def disable!
          return unless @enabled

          @enabled = false
          restore_reline if defined?(Reline::LineEditor)
        end

        # Check if fzf is available in the system
        def fzf_available?
          @fzf_available ||= check_fzf_availability
        end

        # Search IRB history using fzf
        def search
          return if Reline::HISTORY.empty?

          commands_payload = Reline::HISTORY.to_a
                                            .reverse
                                            .uniq
                                            # Create a string with commands separated by null bytes
                                            .join("\0")

          # --read0 tells fzf that the line separator is a null byte,
          # allowing selection of complete multiline commands
          fzf_opts = ['fzf', '--read0', '--no-sort', '-i']

          IO.popen(fzf_opts, 'r+') do |pipe|
            pipe.write(commands_payload)
            pipe.close_write
            pipe.read.strip
          end
        end

        private

        def check_fzf_availability
          system('which fzf > /dev/null 2>&1')
        end

        def patch_reline
          return if Reline::LineEditor.method_defined?(:original_vi_search_prev)

          Reline::LineEditor.class_eval do
            alias_method :original_vi_search_prev, :vi_search_prev

            def vi_search_prev(*)
              use_fzf = ENV.fetch('USE_FZF_REVERSE_I_SEARCH', 'true') != 'false'

              if use_fzf && IRB::FZF::History.fzf_available?
                result = IRB::FZF::History.search

                unless result.nil? || result.empty?
                  clear_rendered_screen_cache
                  set_current_line('', 0)
                  insert_multiline_text(result)
                end
              else
                if use_fzf && !IRB::FZF::History.fzf_available? && !defined?(@fzf_warning_shown)
                  puts "\n💡 For an enhanced search experience, install fzf: https://github.com/junegunn/fzf"
                  @fzf_warning_shown = true
                end
                original_vi_search_prev(*)
              end
            end

            # Reload the alias as Reline sets reverse_search_history to vi_search_prev by default
            # See: reline/lib/reline/line_editor.rb
            alias_method :reverse_search_history, :vi_search_prev
          end
        end

        def restore_reline
          return unless Reline::LineEditor.method_defined?(:original_vi_search_prev)

          Reline::LineEditor.class_eval do
            alias_method :vi_search_prev, :original_vi_search_prev
            alias_method :reverse_search_history, :vi_search_prev
            remove_method :original_vi_search_prev
          end
        end
      end
    end
  end
end
