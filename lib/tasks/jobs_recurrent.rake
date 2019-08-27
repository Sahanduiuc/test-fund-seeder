# frozen_string_literal: true

namespace :jobs do
  namespace :recurrent do
    desc 'Start recurrent jobs'
    task start: :environment do
      GrabberJob.perform_later
      ParserJob.perform_later
    end

    desc 'Stop all recurrent jobs '
    task stop: :environment do
      Delayed::Job.transaction do
        Delayed::Job.lock.where('handler LIKE ?', "%job_class: #{GrabberJob.name}\n%").all.each(&:delete)
        Delayed::Job.lock.where('handler LIKE ?', "%job_class: #{ParserJob.name}\n%").all.each(&:delete)
      end
    end
  end
end
