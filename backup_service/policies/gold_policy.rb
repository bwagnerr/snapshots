require_relative 'policy_base'
module BackupService
  class GoldPolicy
    extend BackupService::PolicyBase
    DAYS = 42
    MONTHS = 12
    YEARS = 0
  end
end
