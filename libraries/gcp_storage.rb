require 'json'

class GcpStorage < Inspec.resource(1)
  name 'gcp_storage'
  desc 'Verifies settings for a bucket'

  example "
    describe gcp_bucket(name: 'my-instance') do
      it { should be_running }
      it { should have_roles }
    end
  "

  def initialize(opts, conn = GCPConnection.new)
    @opts = opts
    @opts.is_a?(Hash) ? @display_name = @opts[:name] : @display_name = opts
    @storage_client = conn.storage_client
    begin
      @bucket = @storage_client.get_bucket(@opts)
    rescue => e
      @error = JSON.parse(e.body)
    end
  end

  def project_number
    if @bucket
      @bucket.project_number.to_s
    else
      return @error['error']['message']
    end
  end
