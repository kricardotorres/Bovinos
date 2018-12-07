  
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
 
every 1.day, :at => '02:36 am' do
 rake "send_report:send_cow_report"
end