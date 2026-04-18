# Example .irbrc configuration for irb-fzf-history
#
# Copy this to your ~/.irbrc file or add the require and enable lines
# to your existing .irbrc configuration

require 'irb-fzf-history'

# Enable fzf integration with IRB's reverse search (Ctrl+R)
IRB::FZF::History.enable!

# Optional: Configure IRB history
IRB.conf[:SAVE_HISTORY] = 10_000
IRB.conf[:HISTORY_FILE] = "#{Dir.home}/.irb_history"

# Optional: Other IRB configurations you might want
IRB.conf[:PROMPT_MODE] = :DEFAULT
IRB.conf[:AUTO_INDENT] = true

puts "🚀 IRB with fzf history search enabled!"
puts "   Press Ctrl+R to search through your command history"
