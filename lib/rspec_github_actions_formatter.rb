require "rspec/core"
require "rspec/core/formatters/progress_formatter"

class RspecGithubActionsFormatter < RSpec::Core::Formatters::ProgressFormatter
  VERSION = "0.2.0"

  RSpec::Core::Formatters.register self, :dump_pending, :dump_failures, :example_passed, :example_pending, :example_failed, :example_started, :start

  def start(example_count)
    @example_count = example_count.count
    @examples_executed = 0
    @tests_per_line = terminal_width - progress_display_width(@example_count)

    super
  end

  def example_started(_notification)
    @examples_executed += 1
  end

  def example_passed(notification)
    super

    split_progress_into_lines(notification)
  end

  def example_pending(notification)
    super

    split_progress_into_lines(notification)
  end

  def example_failed(notification)
    super

    split_progress_into_lines(notification)
  end

  def dump_pending(notification)
    if notification.pending_examples.length > 0
      super
      @output << pending_examples_output(notification)
    end
  end

  def dump_failures(notification)
    if notification.failed_examples.length > 0
      super
      @output << failed_examples_output(notification)
    end
  end

  private

  def split_progress_into_lines(_notification)
    if @examples_executed % @tests_per_line == 0 || @examples_executed == @example_count
      output.print progress_display(@examples_executed, @example_count)
      output.print "\n"
    end
  end

  def pending_examples_output(notification)
    pending_examples_output = notification.pending_examples.map do |example|
      pending_example_output(example)
    end
    build_examples_output(pending_examples_output)
  end

  def pending_example_output(example)
    execution_result = example.execution_result
    message = execution_result.pending_message
    file, line = file_and_line(example.location)

    "::warning file=#{file},line=#{line},#{message}"
  end

  # Loops through all of the failed examples and rebuilds the exception message
  def failed_examples_output(notification)
    failed_examples_output = notification.failed_examples.map do |example|
      failed_example_output example
    end
    build_examples_output(failed_examples_output)
  end

  # Extracts the full_description, location and formats the message of each example exception
  def failed_example_output(example)
    execution_result = example.execution_result
    message = escape_newlines(execution_result.exception.message)
    file, line = file_and_line(example.location)

    "::error file=#{file},line=#{line},#{message}"
  end

  def build_examples_output(output)
    output.join("\n")
  end

  def escape_newlines(message)
    message.gsub('\n', '\\n')
  end

  def file_and_line(location)
    location.delete_prefix("./").split(":")
  end

  def terminal_width
    @terminal_width ||= begin
      require "io/console"
      IO.console.winsize[1]
    rescue LoadError, NoMethodError
      ENV["COLUMNS"].to_i.nonzero? || 80
    end
  end

  def progress_display(executed_examples, total_examples)
    max_width = total_examples.to_s.size
    sprintf " [%#{max_width}d / %#{max_width}d]", executed_examples, total_examples
  end

  def progress_display_width(example_count)
    progress_display(example_count, example_count).size
  end
end
