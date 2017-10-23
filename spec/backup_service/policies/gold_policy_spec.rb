require 'rspec'
require 'date'
require_relative '../../../backup_service/policies'

describe BackupService::GoldPolicy do
  it 'retains the last snapshot of a month for any month on the last 12 months' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(11).prev_day(1)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(true)
  end

  it 'retains snapshots that fall into the standard policy' do
    creation_date = Date.today.prev_day(41)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(true)
  end

  it 'deletes snapshots with more than 42 days and less than 12 months that are not the last of a month' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(3)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes last of a month snapshots older than 12 months' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(12).prev_day(1)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes snapshots that would be covered by platinum policy ' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, 1, 1).prev_year(1).prev_day(1)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes snapshots older than 12 months' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(12)
    expect(BackupService::GoldPolicy.retain?(creation_date)).to be(false)
  end
end
