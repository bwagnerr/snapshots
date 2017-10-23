require 'rspec'
require 'date'
require_relative '../../backup_service/retention'
require_relative '../../backup_service/policies'

describe 'retention plan' do
  describe BackupService::Retention do
    it 'answers the policy retention definition for a certain creation date and policy' do
      expect(BackupService::Retention.new(BackupService::PlatinumPolicy).retain?(Date.today.prev_day(2))).to be(true)
    end
 end
end
