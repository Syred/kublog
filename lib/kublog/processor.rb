# Processes any given task with the method specified in the configuration
# Currently the available processing methods are
# 
# config.notification_processing = :immediate
# config.notification_processing = :delayed_job
module Kublog 
  module Processor
    
    # Proxy method that calls the configuration specified processor
    def self.work(task)
      self.send(Kublog.notification_processing, task)
    end
    
    private
    
    # Immediately calls perform on the task given (No background processing)
    def self.immediate(task)
      task.perform
    end
    
    # Should create a new Job for processing with DeleyedJob
    def self.delayed_job(task)
      Delayed::Job.enqueue(task)
    end
    
  end
end