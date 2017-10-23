module BackupService
  class Retention
    def initialize(policy)
      @policy = policy
    end

    def retain?(date)
      @policy.retain?(date)
    end
  end
end
