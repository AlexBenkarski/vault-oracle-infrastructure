# frozen_string_literal: true

require 'oci/api_client'

module DM
  class CookieHandler
    def initialize()
      @status = {}
    end

    def updateStatus(rawcookie)
      kv = rawcookie.split('; ')[0]
      splitted = kv.split('=')
      @status[splitted[0]] = splitted[1] 
    end

    def extract(set_cookies)
      unless set_cookies.nil? 
        if set_cookies.is_a? String 
          updateStatus(set_cookies)
        else
          set_cookies.each { | cookie |
            updateStatus(cookie)
          }
        end
      end
    end

    def current
      unless @status.empty? 
        return @status.to_a.map { |k, v| "#{k}=#{v}" }.join(';')
      end

      return nil
    end
  end
end