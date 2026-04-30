# GHBS Automation

This project is designed to provide test coverage across multiple areas of the 
GHBS programme, including CMS, Energy, and GHBS Fabs.

The goal is to run the tests nightly, delivering regular feedback to the development 
team on the health of the development and staging environments which will include validation of the 
latest / upcoming features.

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
│   └──  cms
│   │   └── cms_login_page_comps.rb
│   │   └── ...
│   └── dfe_signin
│   │   └── dfe_signin_access_the_service_page_comps.rb
│   │   └── ...
│   └── energy
│   │   └── billing 
│   │   │   └── energy_billing_address_comps.rb
│   │   │   └── ...
│   └── fabs
│   │   └── ...
│
├── features/                  # Feature files and step definitions
│   ├── fabs_search.feature
│   ├── fabs_axe.feature
│   ├── utils_data_management.feature
│   ├── ...
│   ├── step_definitions/
│   │   ├── fabs_home_page_steps.rb
│   │   └── fabs_search_page_steps.rb
│   └── support/
│       ├── env.rb
│       ├── hooks.rb
│       ├── a11y_assertions.rb
│       ├── flags_global_config.rb
│       ├── shared_cms_comps.rb
│       ├── ...
│       └── world/            # World helpers (expose page objects to steps)
│           └── pages.rb
│
├── helpers/                   # Support modules (env loader, screenshot utils etc)
│   ├── env_helpers.rb
│   └── screenshot_helper.rb
│   └── unique_content_helpers.rb
│   └── url_nav_helpers.rb
│   └── validation_helpers.rb
│
├── pages/                     # Core method logic per page
│   └── 
│   └──  cms
│   │   └── cms_find_a_case_methods.rb
│   │   └── ...
│   └── shared
│   │   └── shared_global_methods.rb
│   │   └── ...
│   └── energy
│   │   └── billing 
│   │   │   └── energy_billing_address_methods.rb
│   │   │   └── ...
│   └── fabs
│   │   └── fabs_home_page_methods.rb
│   └──  base_page.rb
│
├── screenshots/               # Test failure screenshots
│
├── reports/
│   ├── allure-results/        # Allure raw results (JSON + attachments)
│   └── allure-report/         # Generated Allure HTML (output)
│
├── .gitignore
├── .secrets.yml.example       # Template for secrets (you will need to generate or request the secrets file from the GHBS dev team)
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

### 5 Install the Allure CLI (for HTML reports)

```bash
brew install allure
```

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

### Local Dev Common Runs 
##### running your current wip
```bash
TEST_ENV=local bundle exec cucumber -p allure_pretty --tags "@wip" allure generate reports/allure-results --clean -o reports/allure-report
```
##### rubuop for code maintenance
```bash
bundle exec rubocop
bundle exec typos
```

Note: if you need to install these then:
```bash
brew install rubocop
brew install typos-cli
```

---

## Test Reporting with Allure

Allure produces rich, clickable HTML reports with scenario details, steps, logs, and screenshots on failure.

- **Configure** (in env.rb)
- **Cucumber profile** (in cucumber.yml)

### Run + Generate HTML (local)

Note: you can change between 

- allure_pretty (step-by-step in console + Allure) or 
- allure_progress (Dots in console + Allure (fast CI style)) 

depending on the kind of report you want.

```bash
# Run tests and always generate the report (even if failures occur)
TEST_ENV=local bundle exec cucumber -p allure_pretty --tags @wip || true                                                                                                                        ✔ │ took 7s │ 3.2.2 Ruby │ at 14:59:47 
allure generate reports/allure-results --clean -o reports/allure-report
```

### Open the report (command line)

```
# Open the report:
allure open reports/allure-report

# Or generate & view instantly:
allure serve reports/allure-results
```

### Open the report (file)

The raw html report is located within root/reports/

```bash
root/reports/allure-report/allure-report/index.html
```

## Accessibility (Selenium Axe)

### Toggle and Hooks:

Before each scenario is run we reset the `ENV["AXE"]` flag in the hooks.rb.

When we create our scenario, we can use the following step (often in the Background) 
to enable the checks on the page.

```
Background:
Given we enable the selenium axe checks on each page
```

From there we simply need to use the `axe_check!` helper located in `features/support/a11y_assertions.rb`. 

Example below:
```
# Rich Example
axe_check!(scope: nil, exclude: nil, rules: %w[wcag2a wcag2aa],
           label: nil, log: true, strip_query: true)
           
# Using Defaults example 
axe_check! 

# Real life use example using our above flag check
axe_check! if FlagsGlobalConfig.axe_enabled?

```
Breakdown: 

- scope – CSS to limit scan (defaults to main,[role="main"] → body)
- exclude – CSS to ignore (e.g. .cookie-banner, cross-origin iframes)
- rules – axe tags (not rule IDs), e.g. wcag2a, wcag2aa
- label – extra context in the log line (e.g. "Footer > Terms")
- strip_query – log /path instead of /path?query=… (default: true)

Example console output
```
[AXE PASS]
  Page Title : Search – GHBS
  Path       : /search
  Scope      : main
  Rules      : wcag2a,wcag2aa
  Duration   : 0.19s
```

Additional examples calling from methods after the page is in the desired state:
```
axe_check!    # smart default scope
axe_check!(scope: ".modal", label: "Checkout modal")
axe_check!(exclude: %w[.cookie-banner iframe.ads])
axe_check!(rules: %w[wcag2a wcag2aa], label: "Footer > T&C")
```

### Alternative Gherkin Use:

So there is an out the box implementation within `axe-core-cucumber` for you 
to use a pre-defined gherkin step. 

```
Then the page should be axe clean according to: wcag2a, wcag2aa
```

Although realistically I find this a little clunky, hence why I 
implemented the above axe_check! call to be used within methods.

### Notes & gotchas

- **iFrames:** Axe can’t scan cross-origin iframes—exclude them or 
test at the source app.
- **Hidden UI:** Open menus/modals before calling axe_check!.
- **Stability:** Logging hides the host and (by default) query strings to avoid secrets and reduce noise.
- **Performance:** Keep checks focused (use scope) on hot paths first; broaden once clean.
- **Terminology:** We use Accessibility (a11y) throughout this repo—a11y is shorthand 
for accessibility, the practice of making products usable by everyone (including people with disabilities), 
derived from a + 11 + y in “accessibility” and widely used in web/QA. 

---

## Automation Framework Blueprint

- **Step Definitions**: Simple glue code, call page methods only.
- **Pages**: Encapsulate test logic for that page (e.g., search, validation).
- **Comps**: Return web elements only. No `.click`, `.set`, etc in this layer.
- **Helpers**: Abstract loading logic, screenshots, configs etc
- **Hooks**: Initial setup and teardown (e.g., screenshots, browser selection).

---

## Screenshot Handling

Screenshots are automatically captured on step failure and saved under `screenshots/` for easy human reference.

However if you are running the allure reports they are also located in the below: 

```bash
root/reports/allure-report/allure-report/data/attachments/
```

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

