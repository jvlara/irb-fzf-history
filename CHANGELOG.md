# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-02-06

### Added

- Initial release
- fzf integration with IRB's reverse search (Ctrl+R)
- Support for multiline commands
- `IRB::FZF::History.enable!` method to activate integration
- `IRB::FZF::History.disable!` method to deactivate integration
- Environment variable `USE_FZF_REVERSE_I_SEARCH` to control behavior
- Graceful fallback when fzf is not available
