begin
  require 'cane/rake_task'
    
  desc 'Run cane for quality metrics'
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 10
    cane.style_measure = 100
    cane.add_threshold 'coverage/covered_percent', :>=, 99
  end

rescue LoadError
  warn "cane not available, quality task not provided."
end
