require 'rspec'
require 'date'
require_relative '../../../backup_service/policies'

describe BackupService::PlatinumPolicy do
  it 'retains the last snapshot of a year for any year on the last 7 years' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, 1, 1).prev_year(6).prev_day(1)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(true)
  end

  it 'retains snapshots that fall into the standard policy' do
    creation_date = Date.today.prev_day(41)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(true)
  end

  it 'retains snapshots that fall into the gold policy' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(11).prev_day(1)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(true)
  end

  it 'deletes snapshots with more than 12 months and less than 7 years that are not the last of an year' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, 1, 1).prev_year(2)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes last of a year snapshots older than 7 years' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, 1, 1).prev_year(8).prev_day(1)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes snapshots older than 7 years' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, 1, 1).prev_year(8)
    expect(BackupService::PlatinumPolicy.retain?(creation_date)).to be(false)
  end
end
