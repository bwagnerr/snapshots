require 'rspec'
require 'date'
require_relative '../../../backup_service/policies'

describe BackupService::StandardPolicy do
  it 'retains any daily snapshots within the last 42 days' do
    creation_date = Date.today.prev_day(41)
    expect(BackupService::StandardPolicy.retain?(creation_date)).to be(true)
  end

  it 'deletes snapshots that would be covered by gold policy' do
    current_date = Date.today
    creation_date = Date.new(current_date.year, current_date.month, 1).prev_month(11).prev_day(1)
    expect(BackupService::StandardPolicy.retain?(creation_date)).to be(false)
  end

  it 'deletes snapshots with more than 42 days' do
    creation_date = Date.today.prev_day(60)
    expect(BackupService::StandardPolicy.retain?(creation_date)).to be(false)
  end
end
