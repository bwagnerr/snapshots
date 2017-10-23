require_relative 'policy_base'
module BackupService
  class StandardPolicy
    extend BackupService::PolicyBase
    DAYS = 42
    MONTHS = 0
    YEARS = 0
  end
end
