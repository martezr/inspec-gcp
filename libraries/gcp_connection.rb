# author: Martez Reed

require 'google/apis'
require 'google/apis/cloudresourcemanager_v1'
require 'google/apis/compute_v1'
require 'google/apis/storage_v1'
require 'googleauth'

class GCPConnection
  def initialize
    scopes =  ['https://www.googleapis.com/auth/cloud-platform',
           'https://www.googleapis.com/auth/compute']
    authorization = Google::Auth.get_application_default(scopes)
    Google::Apis::RequestOptions.default.authorization = authorization
  end

  def compute_client
    @compute_client ||= Google::Apis::ComputeV1::ComputeService.new
  end

  def project_client
    @project_client ||= Google::Apis::CloudresourcemanagerV1::CloudResourceManagerService.new
  end

  def storage_client
    @storage_client ||= Google::Apis::StorageV1::StorageService.new
  end
end
