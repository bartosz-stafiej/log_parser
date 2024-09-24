# Log Praser

## Overview

This repository contains the solution for the Ruby Developer Test. The task is to parse a provided log file and return two lists:
1. A list of webpages with the most page views, ordered from most to least.
2. A list of webpages with the most unique page views, also ordered from most to least.

The goal of this test is to showcase:
- **Functionality**: How the solution works to meet the requirements.
- **Efficiency**: Clean, simple, and efficient code.
- **Readability**: Easily understandable and well-organized code.
- **Test Coverage**: Thorough test cases to maintain high code reliability.
- **Use of TDD and OO**: Ensuring best practices in Test-Driven Development and Object-Oriented Programming are followed.

## Prerequisites

- Ruby 3 installed
- Bundler (for managing dependencies)

## Setup

1. Clone this repository:
    ```bash
    git clone git@github.com:bartosz-stafiej/log_parser.git
    ```
2. Navigate to the project directory:
    ```bash
    cd log_parser
    ```
3. Install the required dependencies:
    ```bash
    bundle install
    ```

## Usage

To run the script, use the following command, where `<log_file>` is the path to your webserver log file:

```bash
ruby bin/run.rb <log_file>
```

For example:

```bash
ruby bin/run.rb webserver.log
```

The output will display:
- The list of webpages with the most page views.
- The list of webpages with the most unique page views.

## Running Tests
This project follows Test-Driven Development (TDD) principles, and the solution is thoroughly tested. To run the tests, use:

```bash
bundle exec rspec
```
Ensure you have good test coverage for all the implemented features, as this project aims for 96% or higher test coverage.

## Code Quality

This project uses [RubyCritic](https://github.com/whitesmith/rubycritic) to analyze code quality and provide insights on code smells, complexity, and maintainability.

### Running RubyCritic

To run RubyCritic and generate a code quality report, execute the following command:

```bash
bundle exec rubycritic
```

The report will be generated and can be accessed through the tmp/rubycritic directory. Open the index.html file in your browser to view the detailed analysis.

## Features
- Log Parsing: Reads a log file and extracts data.
- Page Views: Displays the number of visits per page.
- Unique Views: Displays the number of unique IP visits per page.
- Efficiency: Designed to handle large log files with optimal performance.
- Object-Oriented Design: The code follows clean and maintainable OO principles.

## Example Output
```bash
/home 90 visits
/index 80 visits
/about/2 50 visits
...

/about/2 8 unique views
/index 5 unique views
...
```
