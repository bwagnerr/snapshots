require_relative 'policy_base'
module BackupService
  class PlatinumPolicy
    extend BackupService::PolicyBase
    DAYS = 42
    MONTHS = 12
    YEARS = 7
  end
end
