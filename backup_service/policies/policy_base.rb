module BackupService
  module PolicyBase
    def retain?(created_at)
      retain_daily?(created_at) ||
      retain_monthly?(created_at) ||
      retain_yearly?(created_at)
    end

    def retain_daily?(created_at)
      (created_at..created_at.next_day(self::DAYS)).cover?(Date.today)
    end

    def retain_monthly?(created_at)
      (created_at..created_at.next_month(self::MONTHS)).cover?(Date.today) &&
      created_at == Date.new(created_at.year, created_at.month, -1)
    end

    def retain_yearly?(created_at)
      (created_at..created_at.next_year(self::YEARS)).cover?(Date.today) &&
      created_at == Date.new(created_at.year, 12, -1)
    end
  end
end
