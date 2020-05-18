# Copyright 2016-2018 Shine Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'ruby_aem/error'
# require 'ruby_aem/swagger'
require 'ruby_aem/resources/truststore'
# require 'swagger'

module RubyAem
  module Resources
    # AEM class contains API calls related to managing a certificate within AEM Truststore.
    # Since there is only 0 or 1 AEM Truststore with a global scope, a certificate
    # is by default associated to that global AEM Truststore.
    class Ssl
      # Initialise certificate.
      # Certificate resource uses serial number as identifier because AEM API endpoint
      # for importing a certificate does not allow the ability to specify an alias,
      # hence alias is assigned randomly by AEM, and this force us to use serial
      # number as the identifier because serial number is immutable on the certificate.
      # This is obviously not ideal, but we have to do it due to AEM API limitations.
      #
      # @param client RubyAem::Client
      # @param serial_number the certificate's serial number
      # @return new RubyAem::Resources::Certificate instance
      # def initialize(client, a, b, c, d, e, f)
      def initialize(client, keystore_password, truststore_password, https_hostname, https_port, privatekey_file, certificate_file)
        @client = client
        @call_params = {
          keystore_password: keystore_password,
          keystore_passwordConfirm: keystore_password,
          truststore_password: truststore_password,
          truststore_passwordConfirm: truststore_password,
          https_hostname: https_hostname,
          https_port: https_port,
          privatekey_file: privatekey_file,
          certificate_file: certificate_file,
        }
      end


      # Create is an alias to import.
      # Create is needed to satisfy Puppet resource `ensure`.
      #
      # @param file_path local file path to certificate file
      # @return RubyAem::Result
      # def create(a, b, c, d, e, f)
      # def create(keystore_password, truststore_password, https_hostname, https_port, privatekey_file, certificate_file)
      def create()

        # @call_params[:keystore_password] = keystore_password
        # @call_params[:keystore_passwordConfirm] = keystore_password
        # @call_params[:truststore_password] = truststore_password
        # @call_params[:truststore_passwordConfirm] = truststore_password
        # @call_params[:https_hostname] = https_hostname
        # @call_params[:https_port] = https_port
        # @call_params[:privatekey_file] = File.read privatekey_file
        # @call_params[:certificate_file] = File.read certificate_file
        @client.call(self.class, __callee__.to_s, @call_params)
        # @cert_alias = _get_alias
        # result
      end
    end
  end
end
