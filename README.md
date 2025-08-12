# GHBS Ruby Selenium Cucumber Automation Framework

An automation framework built using Ruby, Cucumber (BDD), and Selenium WebDriver. 

This project is one of the potential POC's for automating UI tests for the
"Get Help Buying for Schools" (GHBS) FABS platform.

---

## Features

- Ruby with Cucumber and Selenium WebDriver
- Simple BDD-style step definitions
- Explicit wait utilities for stability (with custom error logging)
- Cross-browser support
- Screenshot capture on failure

---

## Project Structure

```bash
├── components/                 # returns web elements as objects (POM style!)
│   ├── fabs_home_page_comps.rb        
│   └── fabs_search_page_comps.rb      
│
├── features/                  # Cucumber feature files and step definitions
│   ├── fabs_search.feature            
│   ├── step_definitions/      # Step definitions, call only method modules (no logic)
│   │   ├── driver_setup_steps.rb
│   │   ├── fabs_home_page_steps.rb
│   │   └── fabs_search_page_steps.rb
│   └── support/               # Hooks, env setup etc
│       ├── env.rb
│       └── hooks.rb
│
├── helpers/                   # Helper modules (waits, random, screenshots, file utils)
│   ├── browser_helper.rb
│   ├── date_helpers.rb
│   ├── env_helpers.rb
│   ├── file_helpers.rb
│   └── wait_helpers.rb
│
├── pages/                     # Core auto logic thats supported by comps, helpers, secrets etc
│   ├── fabs_home_page_methods.rb
│   └── fabs_search_page_methods.rb
│
├── screenshots/               # Location for auto-generated screenshots on failure
│
├── .gitignore
├── .secrets.yml               # If you dont generate this yourself you can request this from the tech lead / auto lead on the GHBS project.
├── .secrets.yml.example
├── config.yml                 # Custom Ruby config you control (loaded via helpers)
├── cucumber.yml               # Optional Cucumber CLI profiles (like aliases/macros)
├── Gemfile
└── Gemfile.lock
```

---

## Setup Instructions

### 1. Install Ruby

If you don’t already have Ruby installed:

```bash
brew install ruby   # macOS (with Homebrew)
# OR
sudo apt install ruby-full   # Ubuntu/Debian
```

Ensure you're using the correct version (check `.ruby-version` file):

```bash
ruby -v
```

You can also install Ruby version managers like RVM or rbenv for easier Ruby version control:

- [https://rvm.io/](https://rvm.io/)
- [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

### 2. Install Bundler

```bash
gem install bundler
```

### 3. Install Project Dependencies

```bash
bundle install
```

### 4. Configure Secrets and Settings

Duplicate the secrets template:

```bash
cp .secrets.yml.example .secrets.yml
```

Then update the `base_url`, login credentials, etc. per environment.

The `config.yml` file manages settings per `TEST_ENV` (e.g., default, local, staging). Make sure your desired profile is configured correctly.

Note: You can create as many custom profiles to help you work as you like.

### 5. Run Tests

#### Basic Run

```bash
TEST_ENV=local bundle exec cucumber
```

#### With Chrome browser and specific tag:

```bash
TEST_ENV=local bundle exec cucumber -p chrome --tags @wip
```

Available profiles defined in `cucumber.yml` (e.g., `chrome`, `firefox`, `headless`).

---

## How It Works

- **Step Definitions**: Glue between Gherkin and Ruby. Steps delegate to page method files.
- **Pages**: Contain domain actions like `run_main_search`, which orchestrate interactions via comps.
- **Comps**: Encapsulate low-level element finding and wait logic.
- **Helpers**: Provide shared utilities (waits, config loading, browser methods, etc.).
- **Hooks**: Setup and teardown logic (e.g., browser config, screenshots).

---

## Screenshots on Failure

Screenshots for failed tests are saved to the `screenshots/` directory. Filenames include the scenario name and timestamp.

---

## Configuration

### `.secrets.yml`

Environment-specific credentials and URLs etc.

### `config.yml`

Global runtime config like browser type, headless mode, viewport size.

---

## Example Feature

```gherkin
Feature: GHBS - FABS homepage navigation
  Background:
    Given we open and validate the fabs homepage

  Scenario: FB-1234: Search for Laptop
    Given I search for "laptop" in to the main search on the fabs homepage
    Then I am shown the resulting buying options
```

---

## Example Step Definition

```ruby
Given('I search for {string} in to the main search on the fabs homepage') do |search_term|
  fabs_homepage.run_main_search(search_term)
end
```

---

## Maintenance Tips

- Update URLs or credentials in `.secrets.yml`
- Add new environment profiles in `config.yml`
- Screenshots can be deleted manually or excluded via `.gitignore`
- Use `wait_helpers.rb` for all element interaction waits

---

## Author Notes

If you need any support with this please contact the current auto engineer within the GHBS team.

---

