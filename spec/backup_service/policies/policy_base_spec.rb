require 'rspec'
require 'date'
require_relative '../../../backup_service/policies'

class DailyTest
  DAYS = 2
  MONTHS = 0
  YEARS = 0
  extend BackupService::PolicyBase
end

class MonthlyTest
  DAYS = 0
  MONTHS = 2
  YEARS = 0
  extend BackupService::PolicyBase
end

class YearlyTest
  DAYS = 0
  MONTHS = 0
  YEARS = 2
  extend BackupService::PolicyBase
end

describe BackupService::PolicyBase do
  describe :retain_daily do
    it 'returns true if a day is inside the period' do
      expect(DailyTest.retain_daily?(Date.today.prev_day(1))).to be(true)
    end

    it 'is inclusive with the limit' do
      expect(DailyTest.retain_daily?(Date.today.prev_day(2))).to be(true)
    end

    it 'returns false for the day after the limit' do
      expect(DailyTest.retain_daily?(Date.today.prev_day(3))).to be(false)
    end

    it 'returns false for future dates' do
      expect(DailyTest.retain_daily?(Date.today.next_day(1))).to be(false)
    end

    it 'returns false for policies with no days' do
      expect(MonthlyTest.retain_daily?(Date.today.prev_day(5))).to be(false)
    end
  end

  describe :retain_monthly do
    it 'returns true for the last day of a month inside the period' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).prev_day(1)
      expect(MonthlyTest.retain_monthly?(creation_date)).to be(true)
    end

    it 'is inclusive with the limit' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(1).prev_day(1)
      expect(MonthlyTest.retain_monthly?(creation_date)).to be(true)
    end

    it 'returns false for any other day of a month inside the period' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(1)
      expect(MonthlyTest.retain_monthly?(creation_date)).to be(false)
    end

    it 'returns false for the month after the limit' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(2).prev_day(1)
      expect(MonthlyTest.retain_monthly?(creation_date)).to be(false)
    end

    it 'returns false for future dates' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).next_month(1)
      expect(MonthlyTest.retain_monthly?(creation_date)).to be(false)
    end

    it 'returns false for policies with no months' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, current_date.month, 1).prev_day(1)
      expect(DailyTest.retain_monthly?(creation_date)).to be(false)
    end
  end

  describe :retain_yearly do
    it 'returns true for the last day of an year inside the period' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, 12, -1).prev_year(1)
      expect(YearlyTest.retain_yearly?(creation_date)).to be(true)
    end

    it 'is inclusive with the limit' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, 12, -1).prev_year(2)
      expect(YearlyTest.retain_yearly?(creation_date)).to be(true)
    end

    it 'returns false for any other day of the year inside the period' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, 1, 1).prev_year(1)
      expect(YearlyTest.retain_yearly?(creation_date)).to be(false)
    end

    it 'returns false for the year after the limit' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, 12, -1).prev_year(3)
      expect(YearlyTest.retain_yearly?(creation_date)).to be(false)
    end

    it 'returns false for future dates' do
      current_date = Date.today
      creation_date = Date.new(current_date.year, 12, -1).next_year(1)
      expect(YearlyTest.retain_yearly?(creation_date)).to be(false)
    end
  end
end
