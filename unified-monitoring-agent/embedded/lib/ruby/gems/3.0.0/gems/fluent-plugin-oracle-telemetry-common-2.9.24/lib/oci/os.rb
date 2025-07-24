module OS
    def OS.windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end
  
    def OS.mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
    end
  
    def OS.unix?
      !OS.windows?
    end
  
    def OS.linux?
      OS.unix? and not OS.mac?
    end
  
    def self.ubuntu?
      linux? and os_name_ubuntu?
    end
  
    def self.debian?
      linux? and os_name_debian?
    end
  
    def self.os_name_ubuntu?
      os_name = 'not_found'
      file_name = '/etc/os-release'
      if File.exist?(file_name)
        File.foreach(file_name).each do |line|
          if line.start_with?('ID=')
            os_name = line.split('=')[1].strip
          end
        end
      else
        logger.info('Unknown linux distribution detected')
      end
      os_name == 'ubuntu' ? true : false
    rescue StandardError => e
      log.error "Unable to detect ubuntu platform due to: #{e.message}"
      false
    end
  
    def self.os_name_debian?
      os_name = 'not_found'
      file_name = '/etc/os-release'
      if File.exist?(file_name)
        File.foreach(file_name).each do |line|
          if line.start_with?('ID=')
            os_name = line.split('=')[1].strip
          end
        end
      else
        logger.info('Unknown linux distribution detected')
      end
      os_name == 'debian' ? true : false
    rescue StandardError => e
      log.error "Unable to detect ubuntu platform due to: #{e.message}"
      false
    end
  
  end
  