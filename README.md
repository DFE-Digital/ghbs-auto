# GHBS Ruby Selenium Cucumber Capybara Automation Framework

An automation framework built using Ruby, Cucumber (BDD), Capybara, and Selenium WebDriver.

This project is a refined proof-of-concept for automating UI tests for the 
"Get Help Buying for Schools" (GHBS) platform.

---

## Features

- Ruby with Cucumber and Selenium WebDriver
- Built-in Capybara wait handling
- Cross-browser support (Chrome, Firefox, Edge, Safari, Headless)
- Centralised secrets and config handling via YAML
- Page Object Model with abstraction layers: Comps (elements), Pages (logic), Steps (signposts)
- Screenshot capture on failure
- Clear project structure with support for CI/ENV flexibility

---

## Project Structure

```bash
├── components/                # Element definitions (POM style)
│   ├── fabs_home_page_comps.rb
│   └── fabs_search_page_comps.rb
│
├── features/                  # Feature files and step definitions
│   ├── fabs_search.feature
│   ├── step_definitions/
│   │   ├── fabs_home_page_steps.rb
│   │   └── fabs_search_page_steps.rb
│   └── support/
│       ├── env.rb
│       └── hooks.rb
│
├── helpers/                   # Support modules (env loader, screenshot utils etc)
│   ├── env_helpers.rb
│   └── screenshot_helper.rb
│
├── pages/                     # Core method logic per page
│   └── fabs_home_page_methods.rb
│
├── screenshots/               # Test failure screenshots
│
├── .gitignore
├── .secrets.yml.example       # Template for secrets
├── config.yml                 # Configurable settings per test environment
├── cucumber.yml               # Optional CLI / local profiles for Cucumber
├── Gemfile
└── Gemfile.lock
```

---

## Setup Instructions

### 1. Install Ruby

```bash
brew install ruby   # macOS
# OR
sudo apt install ruby-full   # Ubuntu/Debian
```

You can manage Ruby versions more easily with [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv).

### 2. Install Bundler

```bash
gem install bundler
```

### 3. Install Dependencies

```bash
bundle install
```

### 4. Configure Secrets and Settings

```bash
cp .secrets.yml.example .secrets.yml
```

Update `.secrets.yml` with your URLs and test data, note if you don't have this please contact either 
the Lead Dev or Test on the GHBS project for a copy of this file.

Then configure `config.yml` to specify runtime settings (e.g., browser, view size, wait time).

---

## Running Tests

### Run with default config

```bash
TEST_ENV=default bundle exec cucumber
```

## Running Tests

### Run with default config

```bash
TEST_ENV=default bundle exec cucumber
```

### Run with tag and custom profile

```bash
TEST_ENV=local bundle exec cucumber --tags @wip
```

### Tag Combinations

#### Run scenarios tagged with `@wip` **AND** `@search`
```bash
TEST_ENV=local bundle exec cucumber --tags @wip --tags @search
```

#### Run scenarios tagged with `@wip` **OR** `@search`
```bash
TEST_ENV=local bundle exec cucumber --tags "@wip or @search"
```

#### Run scenarios tagged with `@wip` but **NOT** `@skip`
```bash
TEST_ENV=local bundle exec cucumber --tags "@wip and not @skip"
```

#### Run `@homepage` or `@search`, but **exclude** `@slow`
```bash
TEST_ENV=local bundle exec cucumber --tags "(@homepage or @search) and not @slow"
```

> `TEST_ENV` determines which section of `config.yml` and `.secrets.yml` to use.

---

## How It Works

- **Step Definitions**: Simple glue code, call page methods only.
- **Pages**: Encapsulate test logic for that page (e.g., search, validation).
- **Comps**: Return web elements only. No `.click`, `.set`, etc.
- **Helpers**: Abstract loading logic, screenshots, configs etc
- **Hooks**: Initial setup and teardown (e.g., screenshots, browser selection).

---

## Screenshot Handling

Screenshots are automatically captured on step failure and saved under `screenshots/`.

---

## Configuration Files

### `.secrets.yml`

- Stores environment-specific URLs and secrets

### `config.yml`

- Controls browser, viewport size, and wait time

Example:

```yaml
default:
  browser: firefox
  width: 1920
  height: 1080
  max_wait_time: 5

ci:
  browser: headless_chrome
  width: 1366
  height: 768
  max_wait_time: 10
```

---

## Sample Feature

```gherkin
Feature: GHBS - FABS homepage navigation

  Background:
    Given we open and validate the fabs homepage

  Scenario: Search for Laptop
    Given I search for "laptop" in the main search on the fabs homepage
    Then I am shown the resulting buying options
```

---

## Sample Step Definition

```ruby
Given('I search for {string} in the main search on the fabs homepage') do |term|
  fabs_home_page.search_for(term)
end
```

---
## Author Notes

If you need any support with this please contact the current auto engineer within the GHBS team.

---

