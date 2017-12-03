require_relative 'robot'
require_relative 'table_top'
require 'logger'

module Simulator

  @logger = Logger.new(STDOUT)
  @logger.formatter = proc { |severity, datetime, progname, msg| "#{msg}\n" }

  def self.run(input)
    input.each_line do |line|
      next if line.strip.empty?
      begin
        execute(line)
      rescue InvalidCommand, ArgumentError => e
        @logger.info "Ignored invalid command. #{line.strip}: #{e.message}"
      end
    end
  end

  def self.execute(line)
    command, arguments = line.split(/\s/)
    robot.send(command.strip.downcase, *(arguments && arguments.split(',')))
  end

  def self.robot
    @robot ||= Robot.new(TableTop.new, @logger)
  end
end
