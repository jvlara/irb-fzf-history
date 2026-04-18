# IRB::FZF::History

Integrate [fzf](https://github.com/junegunn/fzf) with IRB's reverse search (Ctrl+R) for a better command history search experience.

## Features

- Replace IRB's default reverse search with fzf's fuzzy finder
- Support for multiline commands
- Fast and intuitive search through command history
- Unique command filtering (no duplicates)
- Easy to enable/disable

## Prerequisites

You need to have [fzf](https://github.com/junegunn/fzf) installed on your system:

```bash
# macOS
brew install fzf

# Ubuntu/Debian
sudo apt install fzf

# Other systems: https://github.com/junegunn/fzf#installation
```by

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'irb-fzf-history'
```

And then execute:

```bash
bundle install
```

Or install it local bundle as:

```bash
gem install irb-fzf-history
```

## Usage

Add the following to your `~/.irbrc` file:

```ruby
require 'irb-fzf-history'

IRB::FZF::History.enable!
```

That's it! Now when you press `Ctrl+R` in IRB, you'll get fzf's fuzzy search interface instead of the default reverse search.

### Environment Variables

You can disable fzf temporarily without modifying your `.irbrc`:

```bash
USE_FZF_REVERSE_I_SEARCH=false irb
```

### Programmatic Control

You can also enable/disable fzf integration programmatically:

```ruby
# Enable fzf integration
IRB::FZF::History.enable!

# Disable fzf integration (restore default behavior)
IRB::FZF::History.disable!

# Check if fzf is available
IRB::FZF::History.fzf_available?
```

## How It Works

This gem monkey-patches Reline's `vi_search_prev` method (triggered by Ctrl+R) to use fzf instead of the built-in reverse search. It properly handles:

- Multiline commands (commands ending with `\`)
- Command history deduplication
- Graceful fallback to default behavior if fzf is not available

## Development

After checking out the repo, run `bundle install` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
