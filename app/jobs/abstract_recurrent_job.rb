# frozen_string_literal: true

class AbstractRecurrentJob < ApplicationJob
  queue_as :grabber_queue
  before_perform :schedule_next_run

  MIN_COUNT_JOBS_IN_QUEUE = 1

  def scheduled_next?
    Delayed::Job.where('handler LIKE ?', "%job_class: #{self.class.name}\n%").count > MIN_COUNT_JOBS_IN_QUEUE
  end

  def schedule_next_run(*_args)
    return if scheduled_next?

    self.class.set(wait: wait_period).perform_later
  end

  def wait_period
    1.hour
  end
end
