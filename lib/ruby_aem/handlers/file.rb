=begin
Copyright 2016 Shine Solutions

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

module RubyAem
  # Response handlers for file payload.
  module Handlers

    # Handle downloaded file by copying from temporary location to file_path info.
    # The downloaded file in temporary location will then be deleted.
    # data, status_code, and headers are all returned from RubyAem::Client call.
    #
    # @param data data payload
    # @param status_code response HTTP status code
    # @param headers response HTTP headers
    # @param response_spec response specification as configured in conf/spec.yaml
    # @param info additional information
    # @return RubyAem::Result
    def Handlers.file_download(data, status_code, headers, response_spec, info)

      FileUtils.cp(data.path, "#{info[:file_path]}/#{info[:package_name]}-#{info[:package_version]}.zip")
      data.delete

      message = response_spec['message'] % info

      RubyAem::Result.new('success', message)
    end

  end
end
