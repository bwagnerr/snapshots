#!/usr/bin/env ruby

require 'date'
require_relative 'backup_service/retention.rb'
require_relative 'backup_service/policies.rb'

current_date = Date.today
standard_date = current_date.prev_day(5)
out_of_standard_date = current_date.prev_day(43)
gold_date = Date.new(current_date.year, current_date.month, 1).prev_month(1).prev_day(1)
out_of_gold_date = Date.new(current_date.year, current_date.month, 1).prev_month(13).prev_day(1)
platinum_date = Date.new(current_date.year, 12, -1).prev_year(2)
out_of_platinum_date = Date.new(current_date.year, 12, -1).prev_year(8)

standard_retention = BackupService::Retention.new(BackupService::StandardPolicy)
gold_retention = BackupService::Retention.new(BackupService::GoldPolicy)
platinum_retention = BackupService::Retention.new(BackupService::PlatinumPolicy)

puts "Basic service consumer"
puts "\n"
puts "Standard Retention"
puts "==="
puts "Retain for date inside standard rentention?"
puts(standard_retention.retain?(standard_date))
puts "Retain for date outside standard rentention?"
puts(standard_retention.retain?(out_of_standard_date))
puts "Retain for date inside gold rentention?"
puts(standard_retention.retain?(gold_date))
puts "Retain for date inside platinum rentention?"
puts(standard_retention.retain?(platinum_date))
puts "\n"
puts "Gold Retention"
puts "==="
puts "Retain for date inside gold rentention?"
puts(gold_retention.retain?(gold_date))
puts "Retain for date outside gold rentention?"
puts(gold_retention.retain?(out_of_gold_date))
puts "Retain for date inside standard rentention?"
puts(gold_retention.retain?(standard_date))
puts "Retain for date inside platinum rentention?"
puts(gold_retention.retain?(platinum_date))
puts "\n"
puts "Platinum Retention"
puts "==="
puts "Retain for date inside platinum rentention?"
puts(platinum_retention.retain?(platinum_date))
puts "Retain for date outside platinum rentention?"
puts(platinum_retention.retain?(out_of_platinum_date))
puts "Retain for date inside standard rentention?"
puts(platinum_retention.retain?(standard_date))
puts "Retain for date inside gold rentention?"
puts(platinum_retention.retain?(gold_date))
